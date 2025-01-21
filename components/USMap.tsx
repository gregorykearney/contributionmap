"use client"

import React, { useState, useCallback, useMemo, useEffect } from 'react';
import { ComposableMap, Geographies, Geography } from 'react-simple-maps';
import { scaleLinear } from 'd3-scale';
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Search, Info } from 'lucide-react'
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip"

// Import the GeoJSON data
import usStatesData from '../public/us-states.json';

const USMap = () => {
  const [tooltipContent, setTooltipContent] = useState('');
  const [selectedState, setSelectedState] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState("");

  useEffect(() => {
    console.log("GeoJSON data:", usStatesData);
  }, []);

  const colorScale = useMemo(() => 
    scaleLinear<string>()
      .domain([0, 1000])
      .range(['#ffedea', '#ff5233']),
  []);

  const getStateColor = useCallback((geo: any) => {
    const stateName = geo.properties.name;
    console.log(`Getting color for state: ${stateName}`);
    switch (stateName) {
      case "California":
        return "#ff0000";
      case "Montana":
        return "#d55d5d";
      case "Texas":
        return "#37ff00";
      default:
        return colorScale(geo.properties.density || 0);
    }
  }, [colorScale]);

  const handleStateClick = useCallback((geo: any) => {
    const { name, density } = geo.properties;
    console.log(`State clicked: ${name}, Density: ${density}`);
    setSelectedState(name);
    setTooltipContent(`${name}: ${density || 'N/A'} people/sq mi`);
  }, []);

  const filteredStates = useMemo(() => 
    usStatesData.features.filter(feature => 
      feature.properties.name.toLowerCase().includes(searchQuery.toLowerCase())
    ).sort((a, b) => a.properties.name.localeCompare(b.properties.name)),
  [searchQuery]);

  return (
    <div className="flex flex-col min-h-screen bg-background">
      <div className="flex flex-col lg:flex-row flex-1">
        {/* Left Sidebar */}
        <div className="w-full lg:w-64 bg-[#8B2332] text-white p-4 lg:min-h-screen">
          <div className="flex items-center gap-2 mb-6">
            <div className="p-2 bg-white/10 rounded">🗺️</div>
            <h1 className="font-semibold">US Population Density Map</h1>
          </div>
          
          <div className="relative mb-4">
            <Search className="absolute left-2 top-2.5 h-4 w-4 text-white/50" />
            <Input
              placeholder="Search US states..."
              className="pl-8 bg-white/10 border-white/10 text-white placeholder:text-white/50"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
          </div>

          <div className="space-y-1 overflow-y-auto max-h-[calc(100vh-200px)] lg:max-h-[calc(100vh-300px)]">
            {filteredStates.map((feature) => (
              <Button
                key={feature.properties.name}
                variant="ghost"
                className={`w-full justify-start ${
                  selectedState === feature.properties.name ? 'bg-white/10' : ''
                }`}
                onClick={() => handleStateClick(feature)}
              >
                {feature.properties.name}
              </Button>
            ))}
          </div>
        </div>

        {/* Main Content */}
        <div className="flex-1 p-6 overflow-y-auto">
          <h1 className="text-4xl font-bold text-[#8B2332] mb-8">US POPULATION DENSITY MAP</h1>
          
          <div className="flex flex-col lg:flex-row gap-8">
            {/* Map */}
            <div className="flex-1">
              <Card className="mb-4">
                <CardContent className="p-4">
                  <ComposableMap projection="geoAlbersUsa">
                    <Geographies geography={usStatesData}>
                      {({ geographies }) =>
                        geographies.map((geo) => (
                          <Geography
                            key={geo.rsmKey}
                            geography={geo}
                            fill={getStateColor(geo)}
                            stroke="#FFFFFF"
                            strokeWidth={0.5}
                            style={{
                              default: { outline: 'none' },
                              hover: { outline: 'none', fill: '#E6E6E6' },
                              pressed: { outline: 'none' },
                            }}
                            onClick={() => handleStateClick(geo)}
                          />
                        ))
                      }
                    </Geographies>
                  </ComposableMap>
                </CardContent>
              </Card>

              {/* Color Scale Legend */}
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Population Density</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="flex items-center mb-2">
                    <div className="w-full h-4 bg-gradient-to-r from-[#ffedea] to-[#ff5233] rounded"></div>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span>0</span>
                    <span>500</span>
                    <span>1000+ people/sq mi</span>
                  </div>
                  <div className="mt-2 flex items-center">
                    <div className="w-4 h-4 bg-[#ff0000] mr-2"></div>
                    <span>California</span>
                  </div>
                  <div className="mt-2 flex items-center">
                    <div className="w-4 h-4 bg-[#d55d5d] mr-2"></div>
                    <span>Montana</span>
                  </div>
                  <div className="mt-2 flex items-center">
                    <div className="w-4 h-4 bg-[#37ff00] mr-2"></div>
                    <span>Texas</span>
                  </div>
                </CardContent>
              </Card>
            </div>

            {/* Selected State Details */}
            <div className="lg:w-72">
              {selectedState ? (
                <Card className="bg-white/95 backdrop-blur-sm shadow-lg border-none sticky top-6">
                  <CardHeader>
                    <CardTitle>{selectedState}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-2">
                      <p><strong>Density:</strong> {usStatesData.features.find(f => f.properties.name === selectedState)?.properties.density || 'N/A'} people/sq mi</p>
                      {selectedState === "California" && (
                        <p><strong>Note:</strong> California is highlighted in red on the map.</p>
                      )}
                      {selectedState === "Montana" && (
                        <p><strong>Note:</strong> Montana is highlighted in pink on the map.</p>
                      )}
                      {selectedState === "Texas" && (
                        <p><strong>Note:</strong> Texas is highlighted in green on the map.</p>
                      )}
                    </div>
                  </CardContent>
                </Card>
              ) : (
                <Card>
                  <CardHeader>
                    <CardTitle>State Details</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p>Select a state to view details</p>
                  </CardContent>
                </Card>
              )}
            </div>
          </div>

          {/* FAQ Section */}
          <Card className="mt-8">
            <CardHeader>
              <CardTitle className="text-2xl font-bold flex items-center gap-2">
                Frequently Asked Questions
                <TooltipProvider>
                  <Tooltip>
                    <TooltipTrigger>
                      <Info className="h-4 w-4" />
                    </TooltipTrigger>
                    <TooltipContent>
                      <p>Common questions about US demographics</p>
                    </TooltipContent>
                  </Tooltip>
                </TooltipProvider>
              </CardTitle>
            </CardHeader>
            <CardContent>
              <Accordion type="single" collapsible className="w-full">
                <AccordionItem value="item-1">
                  <AccordionTrigger>What is population density?</AccordionTrigger>
                  <AccordionContent>
                    Population density is the number of people per unit of area, usually quoted per square mile or square kilometer. It's calculated by dividing the total population by the land area.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-2">
                  <AccordionTrigger>Why are some states colored differently?</AccordionTrigger>
                  <AccordionContent>
                    California (red), Montana (pink), and Texas (green) are colored differently to highlight these specific states. This could be due to various factors such as their large population, economic importance, or to draw attention to specific demographic trends in these states.
                  </AccordionContent>
                </AccordionItem>
              </Accordion>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

export default USMap;

