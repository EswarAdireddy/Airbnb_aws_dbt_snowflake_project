
{% set configs = [
    {
        "TABLE": "AIRBNB.SILVER.SILVER_BOOKINGS",
        "COLUMNS": "b.*",
        "ALIAS": "b"
    },
    {
        "TABLE": "AIRBNB.SILVER.SILVER_LISTINGS",
        "COLUMNS": "l.host_id, l.property_type, l.room_type, l.city, l.country, l.accommodates, l.bedrooms, l.bathrooms, l.price_per_night, l.price_tag, l.created_at as listing_created_at",
        "ALIAS": "l",
        "JOIN_CONDITION": "b.listing_id = l.listing_id"
    },
    {
        "TABLE": "AIRBNB.SILVER.SILVER_HOSTS",
        "COLUMNS": "h.host_name, h.host_since, h.is_superhost, h.response_rate, h.response_rate_quality, h.created_at as host_created_at",
        "ALIAS": "h",
        "JOIN_CONDITION": "l.host_id = h.host_id"
    }
] %}

select
    {% for config in configs %}
        {{ config["COLUMNS"] }}{% if not loop.last %},{% endif %}
    {% endfor %}

from {{ configs[0]["TABLE"] }} as {{ configs[0]["ALIAS"] }}

{% for config in configs[1:] %}
    left join {{ config["TABLE"] }} as {{ config["ALIAS"] }}
        on {{ config["JOIN_CONDITION"] }}
{% endfor %}