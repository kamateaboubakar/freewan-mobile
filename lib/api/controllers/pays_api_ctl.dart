import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wan_mobile/api/abstracts/web_controller.dart';
import 'package:wan_mobile/models/pays.dart';
import 'package:wan_mobile/tools/utils/http_response.dart';

class PaysApiCtl extends WebController {
  Future<HttpResponse<List<Pays>>> getAll() async {
    try {
      final HttpLink httpLink = graphBaseUrl();

      var query = """
       query GetCountryCodes{
          CountryNode {
            edges {
              node {
                id
                code
                name
                ext
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
              data: (responseData!["CountryNode"]["edges"] as List)
                  .map((e) => Pays.fromJson(e))
                  .toList());
        } else {
          return HttpResponse.success(data: []);
        }
      } else {
        return HttpResponse.success(data: []);
      }
    } catch (e) {
      return HttpResponse.error(detailErrors: e.toString());
    }
  }

  //  var response = await client.post(
  //       baseUrl(),
  //       body: {
  //         "query": "query GetCountryCodes{ "
  //             "CountryNode { "
  //             "edges { "
  //             "node { id code name ext } } } }",
  //         "variables": {}
  //       }.toJson(),
  //       headers: headers,
  //     );

  //     var body = HttpResponse.decodeBody(response);
  //     if (body.status) {
  //       return HttpResponse.success(
  //           data: (body.data["data"]["CountryNode"]["edges"] as List)
  //               .map((e) => Pays.fromJson(e))
  //               .toList());
  //     } else {
  //       return HttpResponse.error(message: body.message);
  //     }
  //   } catch (e) {
  //     return HttpResponse.error(detailErrors: e.toString());
  //   }
}
