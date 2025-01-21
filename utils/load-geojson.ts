export async function loadGeoJSON(): Promise<GeoJSONData> {
  try {
    const response = await fetch('/api/us-states.json');
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error loading GeoJSON:', error);
    throw new Error('Failed to load US states data');
  }
}

