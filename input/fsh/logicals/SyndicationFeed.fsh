Logical: SyndicationFeed
Id: syndication-feed
Title: "Terminology Syndication Feed"
Description: """
An Atom 1.0 feed (RFC 4287) used to syndicate terminology releases.

The default XML namespace is `http://www.w3.org/2005/Atom`. Feeds
that use the NCTS ASF profile additionally declare the `ncts:`
namespace and SHOULD include the `⟨ncts:atomSyndicationFormatProfile⟩`
element identifying the profile version.

A feed is an ordered collection of entries (RFC 4287 §4.1). Order
is publisher-defined; consumers MUST NOT rely on order to determine
recency — use the entry-level `updated` element instead.
"""
Characteristics: #can-be-target

* id 1..1 uri "permanent globally-unique feed identifier"
* id ^definition = "Atom feed `⟨id⟩` element. A permanent, globally-unique identifier for the feed itself (not for any artefact). Conventionally `urn:uuid:{uuid}`. MUST NOT change across re-publications of the same feed (RFC 4287 §4.2.6)."

* title 1..1 string "human-readable feed name"
* title ^definition = "Atom feed `⟨title⟩` element. Human-readable feed name (RFC 4287 §4.2.14)."

* subtitle 0..1 string "human-readable feed description"
* subtitle ^definition = "Atom feed `⟨subtitle⟩` element. Human-readable description of the feed (RFC 4287 §4.2.12)."

* updated 1..1 dateTime "instant the feed was last meaningfully modified"
* updated ^definition = "Atom feed `⟨updated⟩` element. The most recent instant the feed was meaningfully modified. RFC 3339 timestamp. SHOULD equal the maximum `⟨updated⟩` of any entry currently in the feed (RFC 4287 §4.2.15)."

* generator 0..1 string "publishing software identifier"
* generator ^definition = "Atom feed `⟨generator⟩` element. Identifies the publishing software (RFC 4287 §4.2.4)."

* link 0..* BackboneElement "feed-level link"
* link ^definition = "Atom feed `⟨link⟩` element. SHOULD include exactly one `rel=\"self\"` link giving the canonical URL of the feed."
  * rel 0..1 code "link relation (self | alternate)"
  * rel ^definition = "Link relation. Common values: `self` (this feed), `alternate` (an alternative representation)."
  * type 0..1 code "media type of the linked resource"
  * type ^definition = "Media type of the linked resource. For `rel=\"self\"`: `application/atom+xml`."
  * href 1..1 uri "target URI"

* atomSyndicationFormatProfile 0..1 uri "ASF profile version the feed conforms to"
* atomSyndicationFormatProfile ^definition = "`⟨ncts:atomSyndicationFormatProfile⟩`. Identifies the ASF profile version this feed conforms to. Current value: `http://ns.electronichealth.net.au/ncts/syndication/asf/profile/1.0.0`. Required when any NCTS ASF extension is used in the feed."

* entry 0..* SyndicationEntry "syndicated artefact entry"
* entry ^definition = "Atom `⟨entry⟩` element. One per syndicated artefact set."
