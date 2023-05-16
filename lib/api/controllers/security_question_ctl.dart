import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/models/security_question.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class SecurityQuestionCtl extends WebController {
  Future<HttpResponse<List<SecurityQuestion>>> getAll() async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      var query = """
          query GetSecurityQuestions {
          SecurityQuestionsNode {
            edges {
              node {
                id
                name
              }
            }
          }
        }
      """;

      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );

      final QueryOptions options = QueryOptions(document: gql(query));
      final QueryResult result = await client.query(options);

      if (!result.hasException) {
        // Traitement de la réponse GraphQL
        if (result.data != null) {
          final responseData = result.data;

          return HttpResponse.success(
              data: (responseData!["SecurityQuestionsNode"]["edges"] as List)
                  .map((e) => SecurityQuestion.fromJson(e))
                  .toList());
        } else {
          return HttpResponse.success(data: []);
        }
      } else {
        return HttpResponse.error();
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }
}
