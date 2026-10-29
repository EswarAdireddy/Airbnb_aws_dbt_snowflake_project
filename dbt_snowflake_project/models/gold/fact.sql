
{% set configs = [
    {
        "TABLE": "AIRBNB.GOLD.OBT",
        "COLUMNS": "g.booking_id, g.listing_id, g.host_id, g.total_booking_amount, g.cleaning_fee, g.service_fee, g.accommodates, g.bedrooms, g.bathrooms, g.price_per_night, g.response_rate",
        "ALIAS": "g"
    }
] %}

select
    {{ configs[0]["COLUMNS"] }}
from {{ configs[0]["TABLE"] }} as {{ configs[0]["ALIAS"] }}
