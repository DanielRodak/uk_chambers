class GitHubRepoProvider {
// method will give us Data model
  Future<List<Chamber>> getCurrentUserRepos() {
    return getGraphQLClient().query(_queryOptions()).then(_toGitHubRepo);
  }

// provides Graph Query options, we can provide the optional variable here
  QueryOptions _queryOptions() {
    return QueryOptions(
      document: readRepositories,
      variables: <String, dynamic>{
        'nRepositories': 50,
      },
    );
  }

// parse JSON to Data model
  List<GithubRepo> _toGitHubRepo(QueryResult queryResult) {
    if (queryResult.hasErrors) {
      throw Exception();
    }

    final list =
    queryResult.data['viewer']['repositories']['nodes'] as List<dynamic>;

    return list
        .map((repoJson) => GithubRepo.fromJson(repoJson))
        .toList(growable: false);
  }
}

// Graph Query to get repository of current user
const String _readRepositories = r'''
  query ReadRepositories($nRepositories: Int!) {
    viewer {
      repositories(last: $nRepositories) {
        nodes {
          name
          createdAt
          forkCount
        }
      }
    }
  }
''';
