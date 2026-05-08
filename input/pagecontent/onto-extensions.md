### Ontoserver Extensions

**Namespace URI:** `http://ontoserver.csiro.au/syndication/`
**Conventional prefix:** `onto`

The Ontoserver namespace carries two extensions: per-entry
permission tags, and a per-link validation flag. These are
optional; feeds that do not need either are not required to
declare the namespace.

### Entry-level elements

#### `onto:permission`

A permission tag that gates access to this entry's artefacts. An
entry MAY carry zero or more permissions. An empty set means no
entry-specific authorisation is required beyond whatever the feed
itself requires.

| Cardinality | Element shape |
|-------------|---------------|
| 0..* | `<onto:permission code="…"/>` |

The `code` attribute is the permission tag. A consumer that does
not hold any of the listed permissions MUST be denied access to
the entry's links. The format does not define how permissions are
issued or how they map to authorisation tokens — see
[Security](security.html).

### Link-level attributes

#### `onto:validated`

Asserts that the publisher has re-verified the artefact at the
link's `href` against `length` and any declared hash since the
entry was last published.

| Type | Default |
|------|---------|
| boolean | `false` |

Useful when artefacts are stored separately from the feed
publisher and may be subject to silent corruption — a `true` value
indicates the publisher has actively checked the artefact since
publishing the entry.

### Example

```xml
<entry>
  <!-- … -->
  <link rel="alternate" type="application/zip"
        href="https://example.org/snomed-au-202211.zip"
        length="274406331"
        ncts:sha256Hash="8130cc90b38e8608380dd80e3b94740584270da5ae79f58d1a5281ac80809095"
        onto:validated="true"/>
  <onto:permission code="snomed-au"/>
  <onto:permission code="licensed-content"/>
</entry>
```
