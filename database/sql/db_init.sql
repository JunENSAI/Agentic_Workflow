-- Meteorological Fact Table
CREATE TABLE IF NOT EXISTS weather_observations (
    id SERIAL PRIMARY KEY,
    observation_timestamp TIMESTAMPTZ NOT NULL,
    temperature_celsius NUMERIC,
    wind_speed_kmh NUMERIC,
    precipitation_mm NUMERIC,
    raw_payload JSONB
);

-- Semantic comments for the AI agent context
COMMENT ON TABLE weather_observations IS 'Stores localized temporal weather data retrieved from Open-Meteo.';
COMMENT ON COLUMN weather_observations.temperature_celsius IS 'Current temperature measured in Celsius.';

-- The Financial Fact Table
CREATE TABLE IF NOT EXISTS market_indices (
    id SERIAL PRIMARY KEY,
    recorded_at TIMESTAMPTZ NOT NULL,
    fiat_currency_code VARCHAR(10),
    bpi_valuation NUMERIC,
    "24h_volume_weighted" NUMERIC,
    raw_payload JSONB
);

-- Semantic comments for the AI agent context
COMMENT ON TABLE market_indices IS 'Captures the continuous financial feed from CoinDesk.';
COMMENT ON COLUMN market_indices.bpi_valuation IS 'Bitcoin Price Index valuation in the specified fiat currency.';

-- The Logistical Fact Table
CREATE TABLE IF NOT EXISTS transit_logistics (
    id SERIAL PRIMARY KEY,
    event_timestamp TIMESTAMPTZ NOT NULL,
    transit_route_id VARCHAR(50),
    station_identifier VARCHAR(100),
    scheduled_arrival_time TIMESTAMPTZ,
    real_time_delay_seconds INTEGER,
    raw_payload JSONB
);

-- Semantic comments for the AI agent context
COMMENT ON TABLE transit_logistics IS 'Records public transit telemetry and delays from the Rennes Métropole network.';
COMMENT ON COLUMN transit_logistics.real_time_delay_seconds IS 'The real-time delay of the transit vehicle measured in seconds.';