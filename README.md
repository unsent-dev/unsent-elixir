# Unsent Elixir SDK

Official Elixir SDK for the [Unsent API](https://unsent.dev) - Send transactional emails,manage contacts, campaigns, and domains.

## Installation

Add `unsent` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:unsent, "~> 1.0.2"}
  ]
end
```

## Quickstart

```elixir
# Initialize client
client = Unsent.new("un_your_api_key")

# Or use environment variable UNSENT_API_KEY
client = Unsent.new()

# Send an email
{:ok, email} = Unsent.Emails.send(client, %{
  to: "user@example.com",
  from: "hello@yourdomain.com",
  subject: "Welcome!",
  html: "<p>Welcome to our service!</p>"
})
```

## Features

- ✅ **Complete API Coverage** - All 60+ API endpoints implemented
- ✅ **Type Safety** - Full `@spec` annotations using auto-generated types
- ✅ Send single and batch emails
- ✅ Manage contacts and contact books
- ✅ Create and schedule campaigns
- ✅ Track analytics, metrics, and stats
- ✅ Monitor activity feed and events
- ✅ Manage domains and verification
- ✅ Handle suppressions and templates
- ✅ Team and system operations
- ✅ Built-in error handling
- ✅ Idempotency support

## Type Safety

The SDK includes complete `@spec` annotations with auto-generated types from the OpenAPI schema:

```elixir
# Type-safe function signatures
@spec send(Client.t(), Types.SendEmailRequest.t() | map(), keyword()) :: {:ok, map()} | {:error, any()}

# Benefits:
# - Better IDE autocomplete
# - Dialyzer static analysis support
# - Clear API contracts
# - Improved documentation
```

## API Documentation

### Client Initialization

```elixir
# With API key
client = Unsent.new("un_xxx")

# With options
client = Unsent.new("un_xxx", 
  base_url: "https://api.unsent.dev/v1", 
  raise_on_error: false
)
```

### Emails

#### Send Email

```elixir
{:ok, email} = Unsent.Emails.send(client, %{
  to: "user@example.com",
  from: "hello@company.com",
  subject: "Hello",
  html: "<p>Email content</p>",
  text: "Email content"
})
```

#### With Attachments

```elixir
Unsent.Emails.send(client, %{
  to: "user@example.com",
  from: "hello@company.com",
  subject: "Document",
  html: "<p>See attachment</p>",
  attachments: [
    %{filename: "doc.pdf", content: "base64-content"}
  ]
})
```

#### Scheduled Email

```elixir
scheduled_time = DateTime.utc_now() |> DateTime.add(3600, :second)

Unsent.Emails.send(client, %{
  to: "user@example.com",
  from: "hello@company.com",
  subject: "Scheduled",
  html: "<p>Sent later</p>",
  scheduledAt: DateTime.to_iso8601(scheduled_time)
})
```

#### Batch Send (up to 100 emails)

```elixir
emails = [
  %{to: "user1@example.com", from: "hello@company.com", subject: "Hi 1", html: "<p>1</p>"},
  %{to: "user2@example.com", from: "hello@company.com", subject: "Hi 2", html: "<p>2</p>"}
]

{:ok, result} = Unsent.Emails.batch(client, emails)
```

#### Idempotent Send

```elixir
Unsent.Emails.send(client, payload, 
  headers: [{"Idempotency-Key", "unique-key-123"}]
)
```

#### List Emails

```elixir
# List all
{:ok, emails} = Unsent.Emails.list(client)

# With filters
Unsent.Emails.list(client, 
  page: 1, 
  limit: 50,
  startDate: "2024-01-01T00:00:00Z",
  endDate: "2024-12-31T23:59:59Z",
  domainId: "domain_123"
)

# Filter by multiple domains
Unsent.Emails.list(client, domainId: ["domain_1", "domain_2"])
```

#### Get Email

```elixir
{:ok, email} = Unsent.Emails.get(client, "email_id")
```

#### Update Email

```elixir
Unsent.Emails.update(client, "email_id", %{
  scheduledAt: "2024-12-01T10:00:00Z"
})
```

#### Cancel Scheduled Email

```elixir
Unsent.Emails.cancel(client, "email_id")
```

#### Get Email Events

```elixir
# Bounces
{:ok, bounces} = Unsent.Emails.get_bounces(client, page: 1, limit: 20)

# Complaints
{:ok, complaints} = Unsent.Emails.get_complaints(client)

# Unsubscribes
{:ok, unsubscribes} = Unsent.Emails.get_unsubscribes(client)
```

### Contact Books

```elixir
# List all contact books
{:ok, books} = Unsent.ContactBooks.list(client)

# Create contact book
{:ok, book} = Unsent.ContactBooks.create(client, %{
  name: "Newsletter Subscribers"
})

# Get contact book
{:ok, book} = Unsent.ContactBooks.get(client, "book_id")

# Update contact book
Unsent.ContactBooks.update(client, "book_id", %{name: "Updated Name"})

# Delete contact book
Unsent.ContactBooks.delete(client, "book_id")
```

### Contacts

```elixir
# List contacts in a book
{:ok, contacts} = Unsent.Contacts.list(client, "book_id")

# With filters
Unsent.Contacts.list(client, "book_id",
  page: 1,
  limit: 50,
  emails: "user1@example.com,user2@example.com",
  ids: "contact_1,contact_2"
)

# Create contact
{:ok, contact} = Unsent.Contacts.create(client, "book_id", %{
  email: "user@example.com",
  firstName: "John",
  lastName: "Doe",
  data: %{plan: "premium"}
})

# Get contact
{:ok, contact} = Unsent.Contacts.get(client, "book_id", "contact_id")

# Update contact
Unsent.Contacts.update(client, "book_id", "contact_id", %{
  firstName: "Jane"
})

# Upsert contact (create or update)
Unsent.Contacts.upsert(client, "book_id", "contact_id", %{
  email: "user@example.com",
  firstName: "John"
})

# Delete contact
Unsent.Contacts.delete(client, "book_id", "contact_id")
```

### Campaigns

```elixir
# List campaigns
{:ok, campaigns} = Unsent.Campaigns.list(client)

# Create campaign
{:ok, campaign} = Unsent.Campaigns.create(client, %{
  name: "Welcome Series",
  subject: "Welcome to {{company}}!",
  html: "<p>Hi {{firstName}}</p>",
  from: "hello@company.com",
  contactBookId: "book_id"
})

# Get campaign
{:ok, campaign} = Unsent.Campaigns.get(client, "campaign_id")

# Schedule campaign
Unsent.Campaigns.schedule(client, "campaign_id", %{
  scheduledAt: "2024-12-01T10:00:00Z"
})

# Pause campaign
Unsent.Campaigns.pause(client, "campaign_id")

# Resume campaign
Unsent.Campaigns.resume(client, "campaign_id")
```

### Domains

```elixir
# List domains
{:ok, domains} = Unsent.Domains.list(client)

# Create domain
{:ok, domain} = Unsent.Domains.create(client, %{
  name: "yourdomain.com",
  region: "us-east-1"
})

# Verify domain
Unsent.Domains.verify(client, "domain_id")

# Get domain
{:ok, domain} = Unsent.Domains.get(client, "domain_id")

# Delete domain
Unsent.Domains.delete(client, "domain_id")
```

### Templates

```elixir
# List templates
{:ok, templates} = Unsent.Templates.list(client)

# Create template
{:ok, template} = Unsent.Templates.create(client, %{
  name: "Welcome Email",
  subject: "Welcome {{name}}!",
  html: "<h1>Hi {{name}}</h1><p>Welcome to {{company}}</p>"
})

# Get template
{:ok, template} = Unsent.Templates.get(client, "template_id")

# Update template
Unsent.Templates.update(client, "template_id", %{
  subject: "Updated: Welcome {{name}}!"
})

# Delete template
Unsent.Templates.delete(client, "template_id")
```

### Suppressions

```elixir
# List all suppressions
{:ok, suppressions} = Unsent.Suppressions.list(client)

# With filters
Unsent.Suppressions.list(client,
  page: 1,
  limit: 50,
  search: "example.com",
  reason: "HARD_BOUNCE" # or "COMPLAINT", "MANUAL", "UNSUBSCRIBE"
)

# Add to suppression list
Unsent.Suppressions.add(client, %{
  email: "blocked@example.com",
  reason: "MANUAL"
})

# Remove from suppression list
Unsent.Suppressions.delete(client, "blocked@example.com")
```

### Analytics

```elixir
# Get overall analytics
{:ok, analytics} = Unsent.Analytics.get(client)

# Get time series data
Unsent.Analytics.get_time_series(client, days: 30)
Unsent.Analytics.get_time_series(client, days: 7, domain: "yourdomain.com")

# Get reputation score
Unsent.Analytics.get_reputation(client)
Unsent.Analytics.get_reputation(client, domain: "yourdomain.com")
```

### System

```elixir
# Health check
{:ok, health} = Unsent.System.health(client)
# => %{"status" => "ok", "uptime" => 12345, ...}

# Version information
{:ok, version} = Unsent.System.version(client)
# => %{"version" => "1.0.0", "environment" => "production", ...}
```

### Activity

```elixir
# Get activity feed
{:ok, activity} = Unsent.Activity.get(client)

# With pagination
Unsent.Activity.get(client, page: 2, limit: 20)
```

### Teams

```elixir
# Get current team
{:ok, team} = Unsent.Teams.get(client)

# List all teams
{:ok, teams} = Unsent.Teams.list(client)
```

### Events

```elixir
# List all events
{:ok, events} = Unsent.Events.list(client)

# With filters
Unsent.Events.list(client,
  page: 1,
  limit: 50,
  status: "DELIVERED",
  startDate: "2024-01-01T00:00:00Z"
)
```

### Metrics

```elixir
# Get performance metrics
{:ok, metrics} = Unsent.Metrics.get(client)

# For specific period
Unsent.Metrics.get(client, period: "week") # or "day", "month"
```

### Stats

```elixir
# Get email statistics
{:ok, stats} = Unsent.Stats.get(client)

# With date range
Unsent.Stats.get(client,
  startDate: "2024-01-01",
  endDate: "2024-01-31"
)
```

### Domain Analytics & Stats

```elixir
# Get analytics for specific domain
{:ok, analytics} = Unsent.Domains.get_analytics(client, "domain_id")
Unsent.Domains.get_analytics(client, "domain_id", period: "week")

# Get stats for specific domain
{:ok, stats} = Unsent.Domains.get_stats(client, "domain_id")
Unsent.Domains.get_stats(client, "domain_id", 
  startDate: "2024-01-01",
  endDate: "2024-01-31"
)
```

### Email Events

```elixir
# Get events for a specific email
{:ok, events} = Unsent.Emails.get_events(client, "email_id")
Unsent.Emails.get_events(client, "email_id", page: 1, limit: 20)
```

### Settings

```elixir
# Get team settings
{:ok, settings} = Unsent.Settings.get(client)
```

### API Keys

```elixir
# List API keys
{:ok, keys} = Unsent.ApiKeys.list(client)

# Create API key
{:ok, key} = Unsent.ApiKeys.create(client, %{
  name: "Production Key",
  permission: "FULL" # or "SENDING"
})

# Delete API key
Unsent.ApiKeys.delete(client, "key_id")
```

### Webhooks (Future Feature)

> **Note**: Webhooks are currently in development and not fully implemented on the server side yet.

```elixir
# List webhooks
Unsent.Webhooks.list(client)

# Create webhook
Unsent.Webhooks.create(client, %{
  url: "https://example.com/webhook",
  events: ["email.sent", "email.delivered", "email.bounced"]
})

# Get specific webhook
Unsent.Webhooks.get(client, "webhook_id")

#Update webhook
Unsent.Webhooks.update(client, "webhook_id", %{
  events: ["email.sent", "email.delivered"]
})

# Test webhook
Unsent.Webhooks.test(client, "webhook_id")

# Delete webhook
Unsent.Webhooks.delete(client, "webhook_id")
```

## Error Handling

By default, the SDK raises exceptions on errors:

```elixir
try do
  Unsent.Emails.send(client, invalid_payload)
rescue
  e in Unsent.HTTPError ->
    IO.puts("Error: #{e.error["message"]}")
    IO.puts("Status: #{e.status_code}")
end
```

Return tuples instead of raising:

```elixir
client = Unsent.new("un_xxx", raise_on_error: false)

case Unsent.Emails.send(client, payload) do
  {:ok, email} -> IO.puts("Success!")
  {:error, error} -> IO.puts("Failed: #{error["message"]}")
end
```

## Testing

Integration tests are available in `examples/elixir-example`:

```bash
cd examples/elixir-example
source .env.local && mix test test/integration_test.exs
```

## Resources

- [Documentation](https://docs.unsent.dev)
- [API Reference](https://docs.unsent.dev/api-reference)
- [Dashboard](https://app.unsent.dev)
- [GitHub](https://github.com/unsent-dev/elixir-sdk)

## License

MIT
