import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/models/user.dart';

import 'package:wan_mobile/tools/utils/http_response.dart';

class UserApiCtl extends WebController {
  Future<HttpResponse<bool>> register(User user) async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      const String saveUserIdMutation = r'''
          mutation SaveUserId($id: ID!, $firstName: String!, $lastName: String!, $email: String! ) {
          updateUsers(
            id: $id
            firstName: $firstName
            lastName: $lastName
            email: $email
          ) {
            success
            errors
            users {
              id
              phoneNumber
            }
          }
        }
      ''';

      final MutationOptions options = MutationOptions(
        document: gql(saveUserIdMutation),
        variables: {
          "id": user.id,
          "firstName": user.prenom,
          "lastName": user.nom,
          "email": user.email,
        },
      );

      final QueryResult result = await client.mutate(options);
      if (!result.hasException) {
        return HttpResponse.success(data: true);
      } else {
        print(result.exception);
        return HttpResponse.error();
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<HttpResponse<bool>> saveUsersSecuriteQuestionAnswers(
      SecurityQuestion question, String userId) async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      const String saveUserIdMutation = r'''
          mutation SaveUsersAnswers ($userId: ID!, $questionId: ID!, $answer: String!) {
            createUsersSecurityQuestions (
              questions : $questionId
              user: $userId
              questionAnswers: $answer
            ) {
              success
              errors
              usersSecurityQuestions {
                id
                questionAnswers
                questions {
                  id
                  name
                }
              }
            }
          }
      ''';

      final MutationOptions options = MutationOptions(
        document: gql(saveUserIdMutation),
        variables: {
          "userId": userId,
          "questionId": question.id,
          "answer": question.answer,
        },
      );
      QueryResult result = await client.mutate(options);

      if (!result.hasException) {
        return HttpResponse.success(data: true);
      } else {
        return HttpResponse.error();
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<HttpResponse<String>> loginPhone(
      {required String phone,
      required int countryCode,
      required String firebaseUserId}) async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      const String saveUserIdMutation = r'''
        mutation SaveUserId($id: ID!, $phoneNumber: String!, $countryCode: ID!) {
          createUsers(
            id: $id
            phoneNumber: $phoneNumber
            countryCode: $countryCode
          ) {
            success
            errors
            otp
            users {
              id
              phoneNumber
            }
          }
        }
      ''';

      final MutationOptions options = MutationOptions(
        document: gql(saveUserIdMutation),
        variables: <String, dynamic>{
          'id': firebaseUserId,
          'phoneNumber': phone,
          'countryCode': countryCode,
        },
      );

      final QueryResult result = await client.mutate(options);
      if (!result.hasException) {
        final data = result.data!['createUsers'];
        final success = data['success'];
        final errors = data['errors'];
        final users = data['users'];
        final id = users['id'];
        final phoneNumber = users['phoneNumber'];
        final codeOTP = data['otp'];
        if (kDebugMode) {
          print('Success: $success');
          print('Errors: $errors');
          print('User ID: $id');
          print("OTP: $codeOTP");
          print('Phone Number: $phoneNumber');
        }
        return HttpResponse.success(data: codeOTP);
      } else {
        if (kDebugMode) {
          print(result.exception);
        }
        if (result.exception.toString().contains("users_pkey")) {
          return HttpResponse.error(
              message: "Désolé, vous avez déjà un compte.",
              detailErrors: "users_pkey");
        }
        return HttpResponse.error();
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }

  // Future<HttpResponse<bool>> verifyOtp(
  //     {required String code, required String phone}) async {
  //   try {
  //     var response = await client.post(
  //       baseUrl(module: "verify-otp"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json"
  //       },
  //       body: jsonEncode({"code": code, "login": phone}),
  //     );
  //     var body = HttpResponse.decodeBody(response);
  //     if (body.status) {
  //       return HttpResponse.success(data: true);
  //     } else {
  //       return HttpResponse.error();
  //     }
  //   } catch (e) {
  //     return HttpResponse.error();
  //   }
  // }

  Future<HttpResponse<SecurityQuestion>> verifyOtp(
      {required String code, required String phone}) async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      var query = """
          query GetUsersAnswer(\$userId: ID!) {
          UsersById(id: \$userId){
            username
            phoneNumber
            userssecurityquestionsSet {
              edges {
                node {
                  id
                  questionAnswers
                  questions {
                    id
                    name
                  }
                }
              }
            }
          }
        }
      """;

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      final QueryOptions options = QueryOptions(
        document: gql(query),
      );
      final QueryResult result = await client.query(options);

      if (!result.hasException) {
        // Traitement de la réponse GraphQL
        if (result.data != null) {
          final responseData = result.data;

          return HttpResponse.success(
              data: SecurityQuestion.fromJson(
                  responseData!["CountryNode"]["edges"]));
        } else {
          return HttpResponse.error();
        }
      } else {
        return HttpResponse.error();
      }
    } catch (e) {
      return HttpResponse.error();
    }
  }

  Future<HttpResponse<List<SecurityQuestion>>> getUsersAnswer(
      {required String userId}) async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      var query = r"""
          query GetUsersAnswer($userId: ID!) {
          UsersById(id: $userId){
            username
            phoneNumber
            userssecurityquestionsSet {
              edges {
                node {
                  id
                  questionAnswers
                  questions {
                    id
                    name
                  }
                }
              }
            }
          }
        }
      """;

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: {"userId": userId},
      );
      final QueryResult result = await client.query(options);

      if (!result.hasException) {
        // Traitement de la réponse GraphQL
        if (result.data != null) {
          final responseData = result.data;

          return HttpResponse.success(
              data: (responseData!["UsersById"]["userssecurityquestionsSet"]
                      ["edges"] as List)
                  .map((e) => SecurityQuestion.toResponse(e))
                  .toList());
        } else {
          return HttpResponse.error();
        }
      } else {
        return HttpResponse.error();
      }
    } catch (e, st) {
      print(st);
      return HttpResponse.error();
    }
  }
}
