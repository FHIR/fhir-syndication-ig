### Security

This specification covers the *format* of the syndication feed —
not the transport, authentication, or authorisation mechanisms used
to serve it. Those are publisher-defined.

The format does, however, provide one authorisation-related
mechanism: the **per-entry permission tag**.

### Per-entry permissions

An entry MAY carry one or more `<onto:permission code="…"/>`
elements (see [Ontoserver Extensions](onto-extensions.html)). Each
permission code is an opaque tag. The intended semantics are:

- A consumer holds zero or more permission codes (assigned out of
  band — typically from claims in an OAuth 2.0 / OIDC access
  token).
- An entry with no `onto:permission` elements is unrestricted at
  the entry level.
- An entry with one or more `onto:permission` elements is
  accessible only to consumers holding **at least one** of the
  listed codes.
- A publisher serving the feed over an authenticated channel MUST
  filter or redact entries whose permissions the consumer does not
  hold — either by omitting the entry, or by omitting the artefact
  links while leaving the metadata visible.

The format does not prescribe:

- How permission codes are minted or registered.
- How they map to OAuth scopes, OIDC claims, or other
  authorisation primitives.
- Whether feed-level authorisation is required to retrieve the
  feed document itself.

### Integrity

The format guarantees artefact integrity through the hash
attributes on `<link>`:

- `sct:md5Hash` — legacy MD5
- `ncts:sha256Hash` — current SHA-256

A consumer MUST verify at least one declared hash before treating a
downloaded artefact as authoritative. When both are present,
`ncts:sha256Hash` is authoritative.

The format does not specify an end-to-end signing mechanism for the
feed document itself. Publishers requiring document-level integrity
typically rely on TLS in transit and HTTPS-delivered feed URIs.
