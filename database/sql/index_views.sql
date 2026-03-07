-- B-Tree Indexes on timestamp columns for time-series optimization
CREATE INDEX IF NOT EXISTS idx_weather_timestamp 
    ON weather_observations USING btree(observation_timestamp);

CREATE INDEX IF NOT EXISTS idx_market_timestamp 
    ON market_indices USING btree(recorded_at);

CREATE INDEX IF NOT EXISTS idx_transit_timestamp 
    ON transit_logistics USING btree(event_timestamp);

-- B-Tree Indexes on foreign keys/identifiers for faster joins
CREATE INDEX IF NOT EXISTS idx_transit_route 
    ON transit_logistics USING btree(transit_route_id);

CREATE INDEX IF NOT EXISTS idx_transit_station 
    ON transit_logistics USING btree(station_identifier);

-- Analytical View
CREATE OR REPLACE VIEW hourly_urban_analytics AS
SELECT 
    date_trunc('hour', w.observation_timestamp) AS analytical_hour,
    AVG(w.temperature_celsius) AS avg_temperature,
    SUM(w.precipitation_mm) AS total_precipitation,
    AVG(t.real_time_delay_seconds) AS avg_transit_delay_seconds,
    COUNT(t.id) AS transit_delay_events
FROM 
    weather_observations w
LEFT JOIN 
    transit_logistics t ON date_trunc('hour', w.observation_timestamp) = date_trunc('hour', t.event_timestamp)
GROUP BY 
    1;

-- Provide semantic context to the AI about the view
COMMENT ON VIEW hourly_urban_analytics IS 'An aggregated hourly view correlating weather conditions with transit delays in Rennes.';