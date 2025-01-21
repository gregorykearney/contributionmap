export interface GeoJSONFeature {
  type: "Feature";
  properties: {
    name: string;
    density: number;
  };
  geometry: {
    type: string;
    coordinates: number[][][];
  };
}

export interface GeoJSONData {
  type: "FeatureCollection";
  features: GeoJSONFeature[];
}

