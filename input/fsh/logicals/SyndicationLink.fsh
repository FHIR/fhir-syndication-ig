Logical: SyndicationLink
Id: syndication-link
Title: "Terminology Syndication Link"
Description: """
An Atom `link` element (RFC 4287 §4.2.7) inside a syndication entry. The
core Atom attributes carry the artefact URL and media type; the
extension namespaces add file-level integrity and validation
metadata.

## Integrity

A consumer MUST be able to verify a downloaded artefact's integrity.
At least one of `md5Hash` or `sha256Hash` SHOULD be present on every
link whose `rel` is `alternate` or `related`. Where both are
present, `sha256Hash` is authoritative.

The hash is computed over the byte stream that `href` resolves to,
exactly as published — without any decompression or
content-encoding negotiation.

## Length

`length` is the byte count of that same stream. When present, it
MUST match what the `href` resolves to.
"""
Characteristics: #can-be-target

// ── Atom core link attributes ────────────────────────────────────────────
* rel 1..1 code "link relation (alternate | related)"
* rel ^definition = "Link relation. `alternate` denotes the primary artefact; `related` denotes ancillary content (release notes, licence)."

* type 1..1 code "media type of the linked artefact"
* type ^definition = "Media type of the linked artefact (e.g. `application/zip`, `application/pdf`, `application/json`, `application/fhir+json`)."

* href 1..1 uri "artefact download URL"

* length 0..1 unsignedInt "artefact size in bytes"
* length ^definition = "Artefact size in bytes. When present, MUST match the `href` resolution exactly."

// ── Integrity attributes ─────────────────────────────────────────────────
* md5Hash 0..1 string "MD5 hash of the artefact byte stream (32 hex chars)"
* md5Hash ^definition = "`sct:md5Hash`. Lowercase-hex MD5 of the artefact byte stream. 32 hex characters."

* sha256Hash 0..1 string "SHA-256 hash of the artefact byte stream (64 hex chars)"
* sha256Hash ^definition = "`ncts:sha256Hash`. Lowercase-hex SHA-256 of the artefact byte stream. 64 hex characters. When both `md5Hash` and `sha256Hash` are present, `sha256Hash` is authoritative."

// ── Ontoserver link metadata ─────────────────────────────────────────────
* validated 0..1 boolean "publisher has re-verified the artefact"
* validated ^definition = "`onto:validated`. Asserts that the publisher has re-verified the artefact at `href` against `length` and any hash since it was last published. Absence is equivalent to `false`."
