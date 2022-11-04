//
//  File.swift
//  
//
//  Created by Marcus Kida on 31.10.22.
//

import Foundation

let getHomeTimelineMockResponseData = """
[
  {
    "id": "109264839555846597",
    "created_at": "2022-10-31T20:45:38.733Z",
    "in_reply_to_id": null,
    "in_reply_to_account_id": null,
    "sensitive": false,
    "spoiler_text": "",
    "visibility": "public",
    "language": "de",
    "uri": "https://bearologics.social/users/Beartest/statuses/109264839555846597",
    "url": "https://bearologics.social/@Beartest/109264839555846597",
    "replies_count": 0,
    "reblogs_count": 0,
    "favourites_count": 0,
    "edited_at": null,
    "favourited": false,
    "reblogged": false,
    "muted": false,
    "bookmarked": false,
    "pinned": false,
    "content": "\\u003cp\\u003eTEST\\u003c/p\\u003e",
    "reblog": null,
    "application": null,
    "account": {
      "id": "109264780627882231",
      "username": "Beartest",
      "acct": "Beartest",
      "display_name": "",
      "locked": false,
      "bot": false,
      "discoverable": null,
      "group": false,
      "created_at": "2022-10-31T00:00:00.000Z",
      "note": "",
      "url": "https://bearologics.social/@Beartest",
      "avatar": "https://bearologics.social/avatars/original/missing.png",
      "avatar_static": "https://bearologics.social/avatars/original/missing.png",
      "header": "https://bearologics.social/headers/original/missing.png",
      "header_static": "https://bearologics.social/headers/original/missing.png",
      "followers_count": 0,
      "following_count": 0,
      "statuses_count": 1,
      "last_status_at": "2022-10-31",
      "emojis": [],
      "fields": []
    },
    "media_attachments": [],
    "mentions": [],
    "tags": [],
    "emojis": [],
    "card": null,
    "poll": null
  },
  {
    "id": "109264839555846598",
    "created_at": "2022-10-31T20:45:39.733Z",
    "in_reply_to_id": null,
    "in_reply_to_account_id": null,
    "sensitive": false,
    "spoiler_text": "",
    "visibility": "public",
    "language": "de",
    "uri": "https://bearologics.social/users/Beartest/statuses/109264839555846597",
    "replies_count": 0,
    "reblogs_count": 0,
    "favourites_count": 0,
    "edited_at": null,
    "favourited": false,
    "reblogged": false,
    "muted": false,
    "bookmarked": false,
    "pinned": false,
    "content": "\\u003cp\\u003eTEST\\u003c/p\\u003e",
    "reblog": null,
    "application": null,
    "account": {
      "id": "109264780627882231",
      "username": "Beartest",
      "acct": "Beartest",
      "display_name": "",
      "locked": false,
      "bot": false,
      "discoverable": null,
      "group": false,
      "created_at": "2022-10-31T00:00:00.000Z",
      "note": "",
      "url": "https://bearologics.social/@Beartest",
      "avatar": "https://bearologics.social/avatars/original/missing.png",
      "avatar_static": "https://bearologics.social/avatars/original/missing.png",
      "header": "https://bearologics.social/headers/original/missing.png",
      "header_static": "https://bearologics.social/headers/original/missing.png",
      "followers_count": 0,
      "following_count": 0,
      "statuses_count": 1,
      "last_status_at": "2022-10-31",
      "emojis": [],
      "fields": []
    },
    "media_attachments": [],
    "mentions": [],
    "tags": [],
    "emojis": [],
    "card": null,
    "poll": null
  }
]
""".data(using: .utf8)!

let getHomeTimelineMockUrlResponse = HTTPURLResponse(
    url: URL(string: "https://bearologics.social/api/v1/timelines/home")!,
    statusCode: 200,
    httpVersion: nil,
    headerFields: nil
)!

let getHomeTinelineMockResponse = (getHomeTimelineMockUrlResponse, getHomeTimelineMockResponseData)
