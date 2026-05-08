Logical: SyndicationFeedMetadata
Id: syndication-feed-metadata
Title: "Terminology Syndication Feed Metadata"
Description: """
A reduced description of a feed, used inside an entry's
`<source>` element (Atom RFC 4287 §4.2.11).

When an entry is copied, mirrored, or aggregated from one feed into
another, the receiving feed SHOULD preserve the originating feed's
identity by including a `<source>` element on the entry. The
`<source>` element carries enough metadata to recover the
originating feed even if the entry is later detached from any feed
document.

A consumer that re-encounters the same `<entry id>` in two
different feeds can use `<source>` to disambiguate origin.
"""
Characteristics: #can-be-target

* id 0..1 uri "Atom `<id>` of the source feed. Conventionally `urn:uuid:<uuid>`. Same value as the originating feed's `<id>`."
* title 0..1 string "Atom `<title>` of the source feed."
* link 0..* BackboneElement "Atom `<link>` elements from the source feed — typically the source feed's `rel=\"self\"` link."
  * rel 0..1 code "Link relation."
  * type 0..1 code "Media type."
  * href 1..1 uri "Target URI."
