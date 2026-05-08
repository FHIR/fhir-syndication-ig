### NCTS ASF Extensions

**Namespace URI:** `http://ns.electronichealth.net.au/ncts/syndication/asf/extensions/1.0.0`
**Conventional prefix:** `ncts`

The NCTS Atom Syndication Format extension namespace carries the
core terminology metadata that distinguishes a terminology
syndication feed from a generic Atom feed.

### Feed-level elements

#### `ncts:atomSyndicationFormatProfile`

URI declaring the ASF profile version the feed conforms to.

| Cardinality | Type | Where |
|-------------|------|-------|
| 0..1 | `xs:anyURI` | inside `<feed>` |

Current value: `http://ns.electronichealth.net.au/ncts/syndication/asf/profile/1.0.0`.

MUST be present whenever any NCTS ASF extension element appears in
the feed.

### Entry-level elements

#### `ncts:contentItemIdentifier`

Canonical, version-independent identifier of the artefact.

| Cardinality | Type |
|-------------|------|
| 1..1 | `xs:anyURI` |

Stable across versions of the same logical artefact. For FHIR
canonical resources, equals the resource's `url`. For SNOMED CT
modules, the unversioned module URI.

#### `ncts:contentItemVersion`

Canonical, version-specific identifier of this exact release.

| Cardinality | Type |
|-------------|------|
| 1..1 | `xs:anyURI` |

MUST be unique per `<entry>` within a feed. For FHIR canonical
resources, equals `<url>|<version>`. For SNOMED CT modules, the
versioned module URI
(`http://snomed.info/sct/<moduleId>/version/<YYYYMMDD>`).

#### `ncts:fhirVersion`

FHIR version the artefact targets.

| Cardinality | Type |
|-------------|------|
| 0..1 | string, max length 5, format `<major>.<minor>` or `<major>.<minor>.<patch>` |

MUST be present when at least one of the entry's `<category>`
elements has a `FHIR_*` term in the NCTS ASF scheme.

#### `ncts:fhirProfile`

FHIR StructureDefinition canonical(s) the artefact claims
conformance to.

| Cardinality | Type |
|-------------|------|
| 0..* | `xs:anyURI` |

Repeats once per profile. Only meaningful for FHIR artefacts.

#### `ncts:bundleInterpretation`

For artefacts that are FHIR Bundles: a publisher hint describing
how the publisher views the Bundle's contents.

| Cardinality | Type | Permitted values |
|-------------|------|------------------|
| 0..1 | code | `batch`, `collection` |

The value indicates *why the Bundle is included in the feed* —
either as an independent batch of operations (`batch`) or as a
curated collection of resources (`collection`). Codes correspond to
the FHIR `Bundle.type` value set.

This is a hint, not a directive. A consumer that retrieves the
Bundle remains free to process it however it sees fit, and is not
obliged to use the publisher's interpretation. Absence means the
publisher offers no hint and the consumer has full discretion; it
is **not** a default value.

### Link-level attributes

#### `ncts:sha256Hash`

Lowercase-hex SHA-256 of the artefact byte stream. 64 hex
characters. Used as an attribute on `<link>`.

When both `sct:md5Hash` and `ncts:sha256Hash` are present on the
same link, `ncts:sha256Hash` is authoritative.
