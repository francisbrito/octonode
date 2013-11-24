#
# search.coffee: Github search class
#
# Copyright © 2013 Pavan Kumar Sunkara. All rights reserved
#

# Requiring modules

# Helpers
_searchQueryGenerator = (endpoint) ->
	return (q, sort, order, qualifiers, cb) ->
		qArgs = []

		qArgs.push q
		qArgs.push "#{qaKey}:#{qaValue}" for qaKey, qaValue of qualifiers
		qArgs = qArgs.join('+')

		params = ""
		params += "q=#{qArgs}"
		params += "&sort=#{sort}&" if sort
		params += "order=#{order}" if order

		@client.get "/search/#{endpoint}?#{params}", (err, s, b) ->
			return cb(err) if err
			if s isnt 200 then cb(new Error("Search #{endpoint} error")) else cb null, b

# Initiate class
class Search

  constructor: (@client) ->

  # Search repositories
  repos: _searchQueryGenerator 'repositories'

  # Search code
  code: _searchQueryGenerator 'code'

  # Search users
  users: _searchQueryGenerator 'users'

  # Search issues
  issues: _searchQueryGenerator 'issues'


# Export module
module.exports = Search
