class GithubFeed < Feed

   def self.search(github_search_term)
    httparty_response = HTTParty.get("https://api.github.com/users/#{github_search_term}", :headers => {"User-Agent" => "FeedHunter"})
      if httparty_response["message"] = "Not Found"
        @github_user_info = nil
    else
      @github_user_info = {username: httparty_response["name"],
                                        userlink: httparty_response["html_url"],
                                        avatar: httparty_response["avatar_url"]}
    end
    return @github_user_info
  end


end
# <HTTParty::Response:0x7fe00f2ec880 parsed_response=
# {"login"=>"lizrush", "id"=>4978498,
# "avatar_url"=>"https://gravatar.com/avatar/e167bc5200b18b2b56a374c3bff407ca?d=https%3A%2F%2Fidenticons.github.com%2Fc7df8e781805a34dd10b41a30049f787.png&r=x",
# "gravatar_id"=>"e167bc5200b18b2b56a374c3bff407ca",
# "url"=>"https://api.github.com/users/lizrush",
# "html_url"=>"https://github.com/lizrush",
# "followers_url"=>"https://api.github.com/users/lizrush/followers",
#  "following_url"=>"https://api.github.com/users/lizrush/following{/other_user}",
#  "gists_url"=>"https://api.github.com/users/lizrush/gists{/gist_id}",
#   "starred_url"=>"https://api.github.com/users/lizrush/starred{/owner}{/repo}",
#    "subscriptions_url"=>"https://api.github.com/users/lizrush/subscriptions",
#    "organizations_url"=>"https://api.github.com/users/lizrush/orgs",
#    "repos_url"=>"https://api.github.com/users/lizrush/repos",
#    "events_url"=>"https://api.github.com/users/lizrush/events{/privacy}",
#     "received_events_url"=>"https://api.github.com/users/lizrush/received_events",
#     "type"=>"User",
#     "site_admin"=>false,
#      "name"=>"Liz Rush",
#      "company"=>nil,
#       "blog"=>nil,
#       "location"=>"Seattle, WA",
#       "email"=>"liz@lizmrush.com",
#       "hireable"=>false,
#       "bio"=>nil,
#       "public_repos"=>12,
#        "public_gists"=>0,
#        "followers"=>11,
#        "following"=>15,
#        "created_at"=>"2013-07-10T03:38:13Z",
#        "updated_at"=>"2014-01-30T22:27:27Z"},
#        @response=#<Net::HTTPOK 200 OK readbody=true>, @headers={"server"=>["GitHub.com"], "date"=>["Fri, 31 Jan 2014 00:11:07 GMT"], "content-type"=>["application/json; charset=utf-8"], "connection"=>["close"], "status"=>["200 OK"], "x-ratelimit-limit"=>["60"], "x-ratelimit-remaining"=>["50"], "x-ratelimit-reset"=>["1391129892"], "cache-control"=>["public, max-age=60, s-maxage=60"], "last-modified"=>["Thu, 30 Jan 2014 22:27:27 GMT"], "etag"=>["\"96da7911964c3226e519a04265c047c4\""], "vary"=>["Accept", "Accept-Encoding"], "x-github-media-type"=>["github.beta; format=json"], "x-content-type-options"=>["nosniff"], "content-length"=>["1244"], "access-control-allow-credentials"=>["true"], "access-control-expose-headers"=>["ETag, Link, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"], "access-control-allow-origin"=>["*"], "x-github-request-id"=>["43B76F17:7610:162DB77:52EAEA1B"]}>
