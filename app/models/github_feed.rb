class GithubFeed < Feed
   def self.search(github_search_term)
    httparty_response = HTTParty.get("https://api.github.com/users/#{github_search_term}", :headers => {"User-Agent" => "FeedHunter"})
    @github_user = {}
    @github_user = {username: httparty_response["name"],
                                userlink: httparty_response["html_url"],
                                avatar: httparty_response["avatar_url"]}
    return @github_user
  end
end
