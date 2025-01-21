"use client"

import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { ScrollArea } from "@/components/ui/scroll-area"
import { Badge } from "@/components/ui/badge"
import { BarChartIcon as ChartIcon, SearchIcon, TrendingUpIcon, PercentIcon, InfoIcon, MapPinIcon } from 'lucide-react'
import { cn } from "@/lib/utils"
import { Switch } from "@/components/ui/switch"

const educationData = {
  'Massachusetts': [
    { year: 2015, stateContribution: 9.164199, stateContributionWeighted: 9.6161 },
    { year: 2016, stateContribution: 10.688278, stateContributionWeighted: 10.64847 },
    { year: 2017, stateContribution: 11.09102, stateContributionWeighted: 11.18921 },
    { year: 2018, stateContribution: 11.359919, stateContributionWeighted: 11.41919 },
    { year: 2019, stateContribution: 12.20884, stateContributionWeighted: 11.80999 },
    { year: 2020, stateContribution: 13.830588, stateContributionWeighted: 12.02203 },
    { year: 2021, stateContribution: 12.866004, stateContributionWeighted: 12.9144 },
    { year: 2022, stateContribution: 14.059783, stateContributionWeighted: 14.28786 }
  ],
  'California': [
    { year: 2015, totalContribution: 4.87, totalContributionWeighted: 5.16, districtContribution: 3.18, districtContributionWeighted: 3.40, stateContribution: 1.69, stateContributionWeighted: 1.79 },
    { year: 2016, totalContribution: 5.63, totalContributionWeighted: 5.90, districtContribution: 3.58, districtContributionWeighted: 3.79, stateContribution: 2.05, stateContributionWeighted: 2.13 },
    { year: 2017, totalContribution: 6.48, totalContributionWeighted: 6.80, districtContribution: 4.08, districtContributionWeighted: 4.35, stateContribution: 2.41, stateContributionWeighted: 2.49 },
    { year: 2018, totalContribution: 7.23, totalContributionWeighted: 7.50, districtContribution: 4.60, districtContributionWeighted: 4.86, stateContribution: 2.63, stateContributionWeighted: 2.69 },
    { year: 2019, totalContribution: 8.00, totalContributionWeighted: 8.15, districtContribution: 4.15, districtContributionWeighted: 4.38, stateContribution: 3.85, stateContributionWeighted: 3.70 },
    { year: 2020, totalContribution: 8.66, totalContributionWeighted: 8.81, districtContribution: 5.03, districtContributionWeighted: 5.28, stateContribution: 4.13, stateContributionWeighted: 3.94 },
    { year: 2021, totalContribution: 8.10, totalContributionWeighted: 8.19, districtContribution: 4.94, districtContributionWeighted: 5.13, stateContribution: 4.56, stateContributionWeighted: 4.20 },
    { year: 2022, totalContribution: 8.23, totalContributionWeighted: 8.29, districtContribution: 5.00, districtContributionWeighted: 5.19, stateContribution: 4.25, stateContributionWeighted: 3.92 }
  ],
  'Georgia': [
    { year: 2015, totalContribution: 7.03, totalContributionWeighted: 6.87, districtContribution: 6.97, districtContributionWeighted: 6.59, stateContribution: 0.04, stateContributionWeighted: 0.04 },
    { year: 2016, totalContribution: 7.50, totalContributionWeighted: 7.31, districtContribution: 7.43, districtContributionWeighted: 6.98, stateContribution: 0.04, stateContributionWeighted: 0.04 },
    { year: 2017, totalContribution: 7.48, totalContributionWeighted: 7.26, districtContribution: 7.40, districtContributionWeighted: 6.90, stateContribution: 0.03, stateContributionWeighted: 0.03 },
    { year: 2018, totalContribution: 8.64, totalContributionWeighted: 8.11, districtContribution: 8.57, districtContributionWeighted: 7.68, stateContribution: 0.02, stateContributionWeighted: 0.02 },
    { year: 2019, totalContribution: 10.32, totalContributionWeighted: 9.41, districtContribution: 10.19, districtContributionWeighted: 8.81, stateContribution: 0.02, stateContributionWeighted: 0.03 },
    { year: 2020, totalContribution: 10.63, totalContributionWeighted: 9.55, districtContribution: 10.49, districtContributionWeighted: 8.90, stateContribution: 0.02, stateContributionWeighted: 0.03 },
    { year: 2021, totalContribution: 9.48, totalContributionWeighted: 8.82, districtContribution: 9.36, districtContributionWeighted: 8.26, stateContribution: 0.02, stateContributionWeighted: 0.03 },
    { year: 2022, totalContribution: 9.25, totalContributionWeighted: 8.55, districtContribution: 9.13, districtContributionWeighted: 7.99, stateContribution: 0.02, stateContributionWeighted: 0.02 }
  ],
  'Florida': [
    { year: 2015, districtContribution: 4.248185, districtContributionWeighted: 5.05964 },
    { year: 2016, districtContribution: 3.903143, districtContributionWeighted: 4.63565 },
    { year: 2017, districtContribution: 4.05051, districtContributionWeighted: 4.87525 },
    { year: 2018, districtContribution: 4.251444, districtContributionWeighted: 5.15275 },
    { year: 2019, districtContribution: 4.378611, districtContributionWeighted: 5.34659 },
    { year: 2020, districtContribution: 4.577446, districtContributionWeighted: 5.62949 },
    { year: 2021, districtContribution: 5.596217, districtContributionWeighted: 6.86778 },
    { year: 2022, districtContribution: 5.953953, districtContributionWeighted: 7.39541 }
  ],
  'Minnesota': [
    { year: 2015, totalContribution: 4.33, totalContributionWeighted: 4.85, districtContribution: 3.84, districtContributionWeighted: 4.28, stateContribution: 0.47, stateContributionWeighted: 0.53 },
    { year: 2016, totalContribution: 4.28, totalContributionWeighted: 4.82, districtContribution: 3.88, districtContributionWeighted: 4.31, stateContribution: 0.39, stateContributionWeighted: 0.44 },
    { year: 2017, totalContribution: 4.30, totalContributionWeighted: 4.84, districtContribution: 3.90, districtContributionWeighted: 4.36, stateContribution: 0.38, stateContributionWeighted: 0.43 },
    { year: 2018, totalContribution: 4.52, totalContributionWeighted: 4.83, districtContribution: 4.12, districtContributionWeighted: 4.37, stateContribution: 0.39, stateContributionWeighted: 0.42 },
    { year: 2019, totalContribution: 4.48, totalContributionWeighted: 5.12, districtContribution: 4.11, districtContributionWeighted: 4.67, stateContribution: 0.36, stateContributionWeighted: 0.43 },
    { year: 2020, totalContribution: 4.52, totalContributionWeighted: 5.01, districtContribution: 4.17, districtContributionWeighted: 4.58, stateContribution: 0.35, stateContributionWeighted: 0.40 },
    { year: 2021, totalContribution: 4.69, totalContributionWeighted: 5.12, districtContribution: 4.32, districtContributionWeighted: 4.68, stateContribution: 0.36, stateContributionWeighted: 0.41 },
    { year: 2022, totalContribution: 4.72, totalContributionWeighted: 5.17, districtContribution: 4.39, districtContributionWeighted: 4.74, stateContribution: 0.32, stateContributionWeighted: 0.37 }
  ],
  'Texas': [
    { year: 2015, totalContribution: 1.97, totalContributionWeighted: 2.16, districtContribution: 0.92, districtContributionWeighted: 1.00, stateContribution: 1.05, stateContributionWeighted: 1.13 },
    { year: 2016, totalContribution: 1.96, totalContributionWeighted: 2.18, districtContribution: 0.93, districtContributionWeighted: 1.05, stateContribution: 1.03, stateContributionWeighted: 1.12 },
    { year: 2017, totalContribution: 1.94, totalContributionWeighted: 2.18, districtContribution: 0.94, districtContributionWeighted: 1.07, stateContribution: 0.99, stateContributionWeighted: 1.09 },
    { year: 2018, totalContribution: 2.20, totalContributionWeighted: 2.19, districtContribution: 1.09, districtContributionWeighted: 1.09, stateContribution: 1.11, stateContributionWeighted: 1.08 },
    { year: 2019, totalContribution: 2.15, totalContributionWeighted: 2.27, districtContribution: 1.08, districtContributionWeighted: 1.15, stateContribution: 1.06, stateContributionWeighted: 1.10 },
    { year: 2020, totalContribution: 2.35, totalContributionWeighted: 2.45, districtContribution: 1.15, districtContributionWeighted: 1.22, stateContribution: 1.20, stateContributionWeighted: 1.21 },
    { year: 2021, totalContribution: 2.37, totalContributionWeighted: 2.51, districtContribution: 1.18, districtContributionWeighted: 1.28, stateContribution: 1.19, stateContributionWeighted: 1.23 },
    { year: 2022, totalContribution: 2.62, totalContributionWeighted: 2.77, districtContribution: 1.41, districtContributionWeighted: 1.52, stateContribution: 1.21, stateContributionWeighted: 1.25 }
  ]
};

const getYAxisDomain = (state: string) => {
  switch(state) {
    case 'Massachusetts':
      return [8, 16];  // Fixed range covering both 14.06% and 14.29%
    case 'California':
      return [0, 9];   // Fixed range covering both weighted and unweighted max around 8.8%
    case 'Georgia':
      return [0, 11];  // Fixed range covering both weighted (8.9%) and unweighted (10.63%)
    case 'Florida':
      return [3, 8];   // Fixed range covering both 5.95% and 7.40%
    case 'Texas':
      return [0, 3];   // Fixed range covering both 2.62% and 2.77%
    case 'Minnesota':
      return [0, 6];   // Fixed range covering both 4.72% and 5.17%
    default:
      return [0, 16];
  }
};

const renderPensionContributionsChart = (stateData: any, stateName: string, isWeighted: boolean) => (
  <div className="h-[500px]">
    <ResponsiveContainer width="100%" height="100%">
      <LineChart data={stateData} margin={{ top: 20, right: 30, left: 40, bottom: 60 }}>
        <CartesianGrid strokeDasharray="3 3" stroke="#e5e5e5" />
        <XAxis 
          dataKey="year"
          tick={{ fill: '#666' }}
          tickLine={{ stroke: '#666' }}
        />
        <YAxis
          tick={{ fill: '#666' }}
          tickLine={{ stroke: '#666' }}
          label={{ value: 'Percent (%)', angle: -90, position: 'insideLeft', fill: '#666' }}
          domain={getYAxisDomain(stateName)}
          interval={0}
          ticks={(() => {
            const [min, max] = getYAxisDomain(stateName);
            const step = 1;
            const ticks = [];
            for (let i = min; i <= max; i += step) {
              ticks.push(i);
            }
            return ticks;
          })()}
        />
        <Tooltip
          contentStylecontentStyle={{
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            border: '1px solid #e2e8f0',
            borderRadius: '8px',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
          }}
          formatter={(value: number, name: string) => {
            const labels = {
              totalContribution: "Total Contributions",
              totalContributionWeighted: "Total Contributions (Weighted)",
              districtContribution: "District Contributions",
              districtContributionWeighted: "District Contributions (Weighted)",
              stateContribution: "State Contributions",
              stateContributionWeighted: "State Contributions (Weighted)"
            };
            return [`${value.toFixed(2)}%`, labels[name as keyof typeof labels]];
          }}
        />
        <Legend
          verticalAlign="bottom"
          height={36}
          formatter={(value) => {
            const baseLabels = {
              "District Contributions": <span style={{ color: "#0000ff" }}>District Contributions</span>,
              "State Contributions": <span style={{ color: "#666666" }}>State Contributions</span>,
              "Total Contributions": <span style={{ color: "#cc0000" }}>Total Contributions</span>,
              "District Contributions (Weighted)": <span style={{ color: "#0000ff" }}>District Contributions (Weighted)</span>,
              "State Contributions (Weighted)": <span style={{ color: "#666666" }}>State Contributions (Weighted)</span>,
              "Total Contributions (Weighted)": <span style={{ color: "#cc0000" }}>Total Contributions (Weighted)</span>
            };
            return baseLabels[value as keyof typeof baseLabels];
          }}
        />
        <Line
          type="linear"
          dataKey={isWeighted ? "districtContributionWeighted" : "districtContribution"}
          stroke="#0000ff"
          strokeWidth={2}
          strokeDasharray={isWeighted ? "5 5" : "0"}
          name={isWeighted ? "District Contributions (Weighted)" : "District Contributions"}
          dot={{ fill: "#0000ff", r: 3, strokeWidth: 0 }}
        />
        <Line
          type="linear"
          dataKey={isWeighted ? "stateContributionWeighted" : "stateContribution"}
          stroke="#666666"
          strokeWidth={2}
          strokeDasharray={isWeighted ? "5 5" : "0"}
          name={isWeighted ? "State Contributions (Weighted)" : "State Contributions"}
          dot={{ fill: "#666666", r: 3, strokeWidth: 0 }}
        />
        <Line
          type="linear"
          dataKey={isWeighted ? "totalContributionWeighted" : "totalContribution"}
          stroke="#cc0000"
          strokeWidth={2}
          strokeDasharray={isWeighted ? "5 5" : "0"}
          name={isWeighted ? "Total Contributions (Weighted)" : "Total Contributions"}
          dot={{ fill: "#cc0000", r: 3, strokeWidth: 0 }}
        />
      </LineChart>
    </ResponsiveContainer>
  </div>
);

export default function USMap() {
  const [selectedState, setSelectedState] = useState('Massachusetts');
  const [searchQuery, setSearchQuery] = useState("");
  const [isWeighted, setIsWeighted] = useState(true);
  const [filteredStates, setFilteredStates] = useState(Object.keys(educationData));

  const handleSearch = (e: React.ChangeEvent<HTMLInputElement>) => {
    const query = e.target.value.toLowerCase();
    setSearchQuery(query);
    const filtered = Object.keys(educationData).filter(state =>
      state.toLowerCase().includes(query)
    );
    setFilteredStates(filtered);
    if (filtered.length > 0 && !filtered.includes(selectedState)) {
      setSelectedState(filtered[0]);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-background to-muted">
      <div className="container mx-auto px-4 py-6">
        <header className="mb-8">
          <div className="flex items-start justify-between">
            <div className="flex items-start gap-3">
              <div className="rounded-lg bg-primary p-2 mt-1">
                <ChartIcon className="h-6 w-6 text-primary-foreground" />
              </div>
              <div>
                <h1 className="text-2xl font-bold">US Teachers' Pension Funds</h1>
                <p className="text-muted-foreground">Associated education expenditure analysis 2015-2022</p>
                <p className="text-xs text-muted-foreground mt-2">
                  Kearney, Gregory and Joshua Rauh, 2025, "Database of US Teachers' Pension Funds and Associated Expenditure Analysis"
                </p>
              </div>
            </div>
            <div className="flex items-start gap-4 mt-1">
              <div className="relative w-64">
                <SearchIcon className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                <Input
                  placeholder="Search states..."
                  className="pl-9"
                  value={searchQuery}
                  onChange={handleSearch}
                />
              </div>
              <Select
                value={selectedState}
                onValueChange={setSelectedState}
              >
                <SelectTrigger className="w-48">
                  <SelectValue placeholder="Select State" />
                </SelectTrigger>
                <SelectContent>
                  {filteredStates.map(state => (
                    <SelectItem key={state} value={state}>
                      {state}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>
        </header>

        <div className="grid gap-4 sm:gap-6">
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
            <Card className="bg-primary/5">
              <CardHeader className="pb-4">
                <CardTitle className="text-sm font-medium flex items-center gap-2">
                  <PercentIcon className="h-4 w-4" />
                  Average Total Contribution
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">7.47%</div>
                <p className="text-xs text-muted-foreground mt-1">Across all analyzed states</p>
              </CardContent>
            </Card>
            <Card className="bg-primary/5">
              <CardHeader className="pb-4">
                <CardTitle className="text-sm font-medium flex items-center gap-2">
                  <TrendingUpIcon className="h-4 w-4" />
                  Total Change
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">+2.20%</div>
                <p className="text-xs text-muted-foreground mt-1">2015-2022 period</p>
              </CardContent>
            </Card>
            <Card className="bg-primary/5">
              <CardHeader className="pb-4">
                <CardTitle className="text-sm font-medium flex items-center gap-2">
                  <MapPinIcon className="h-4 w-4" />
                  States Analyzed
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">6</div>
                <p className="text-xs text-muted-foreground mt-1">Major education systems</p>
              </CardContent>
            </Card>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 sm:gap-6">
            <Card className="lg:col-span-2">
              <CardHeader>
                <CardTitle>
                  {selectedState}
                </CardTitle>
                <CardDescription>
                  Pension Contributions as a Percentage of Associated Education Expenditures (2015-2022)
                </CardDescription>
                <div className="flex items-center justify-between mt-4">
                  <Badge variant="outline" className="font-mono">
                    {selectedState}
                  </Badge>
                  <div className="flex items-center space-x-2">
                    <span className="text-sm font-medium">Unweighted</span>
                    <Switch
                      checked={isWeighted}
                      onCheckedChange={setIsWeighted}
                      aria-label="Toggle weighted data"
                    />
                    <span className="text-sm font-medium">Weighted</span>
                  </div>
                </div>
              </CardHeader>
              <CardContent className="h-[550px]">
                {filteredStates.includes(selectedState) 
                  ? renderPensionContributionsChart(educationData[selectedState], selectedState, isWeighted)
                  : <div className="h-[500px] flex items-center justify-center">No data available for the selected state.</div>
                }
              </CardContent>
            </Card>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-1 gap-4 sm:gap-6">
              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Key Insights</CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[120px] lg:h-[150px] pr-4">
                    <div className="space-y-4">
                      <div>
                        <h4 className="font-medium mb-2">Highest Contributor</h4>
                        <p className="text-sm text-muted-foreground">
                          Massachusetts leads with 14.10% contribution in 2022, showing consistent growth since 2015.
                        </p>
                      </div>
                      <div>
                        <h4 className="font-medium mb-2">Largest Increase</h4>
                        <p className="text-sm text-muted-foreground">
                          Massachusetts showed the largest increase of 4.94 percentage points from 2015 to 2022, rising from 9.16% to 14.10%.
                        </p>
                      </div>
                    </div>
                  </ScrollArea>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="text-lg">Distribution Analysis</CardTitle>
                </CardHeader>
                <CardContent>
                  <ScrollArea className="h-[200px] lg:h-[250px] pr-4">
                    <div className="space-y-4">
                      {[
                        { state: 'Massachusetts', percentage: 14.06, color: '#FF0000' },
                        { state: 'Georgia', percentage: 9.25, color: '#FF7F50' },
                        { state: 'California', percentage: 8.23, color: '#FFA500' },
                        { state: 'Florida', percentage: 5.95, color: '#FFFF00' },
                        { state: 'Minnesota', percentage: 4.72, color: '#ADFF2F' },
                        { state: 'Texas', percentage: 2.62, color: '#00FF00' },
                      ].map(({ state, percentage, color }) => (
                        <div key={state} className="flex items-center justify-between">
                          <div className="flex items-center gap-2">
                            <div
                              className="w-3 h-3 rounded-full"
                              style={{ backgroundColor: color }}
                            />
                            <span className="text-sm font-medium">{state}</span>
                          </div>
                          <span className="text-sm text-muted-foreground">
                            {percentage.toFixed(2)}%
                          </span>
                        </div>
                      ))}
                    </div>
                  </ScrollArea>
                </CardContent>
              </Card>
            </div>
          </div>

          <Card className="mt-8">
            <CardHeader>
              <CardTitle className="text-2xl font-bold">Summary</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <p>
                  The figures above summarize the extent to which pension contributions as a proportion of associated education expenditures have changed between the years 2015-2022, which we more fully explain in a <a href="https://www.hoover.org/research/state-pension-contributions-and-their-impact-state-education-budgets" className="text-primary underline" target="_blank" rel="noopener noreferrer">recent report</a> published by the Hoover Institution. Across the states studied, we have seen an increase in more than 2 percentage points in the amount of money slated for education budgets going toward pension contributions as opposed to other important expenditures such as new teachers, increases to teacher salaries, or increases to funds for assorted class resources.
                </p>
                <p>
                  While this may on its face seem negligible, the reality is that that each percentage point translates to millions of dollars from state education budgets going toward pension systems to attempt to keep pace with ever rising pension liabilities.
                </p>
                <p>
                  To put this in perspective consider an example we have discussed in a <a href="https://www.bostonglobe.com/2024/12/02/opinion/massachusetts-education-teacher-pension-plans/" className="text-primary underline" target="_blank" rel="noopener noreferrer">recent op-ed</a> in the Boston Globe where we discussed the present situation in Massachusetts where pension contributions as a percentage of all education expenditures has increased almost 5 percentage points between 2015-2022. The education budget for fiscal year 2024 was $7.95 billion, and thus a five-percentage point increase translates to an additional $398 million toward the pension system than if the share had remained at its 2015 level.
                </p>
                <p>
                  Our aim is to track the changes across all 50 states, and we will be updating this site with new states in the coming months to give a more comprehensive understanding of how much pension contributions are eating away at education budgets nationally.
                </p>
              </div>
            </CardContent>
          </Card>

          <Card className="mt-4">
            <CardHeader>
              <CardTitle className="text-xl font-bold">Key Terms</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div>
                  <h4 className="font-medium">District Contributions %</h4>
                  <p className="text-sm text-muted-foreground">
                    The district-level proportion of all associated education expenditures made to the appropriate pension system.
                  </p>
                </div>
                <div>
                  <h4 className="font-medium">State Contributions %</h4>
                  <p className="text-sm text-muted-foreground">
                    The state-level proportion of all associated education expenditures made to the appropriate pension system.
                  </p>
                </div>
                <div>
                  <h4 className="font-medium">Total Contributions %</h4>
                  <p className="text-sm text-muted-foreground">
                    The total proportion of all associated education expenditures made to the appropriate pension system.
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

