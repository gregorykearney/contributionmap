"use client"

import { useState } from 'react'
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts'
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Badge } from "@/components/ui/badge"

const educationData = {
  'Massachusetts': [
    { year: 2015, totalContribution: 9.16, totalContributionWeighted: 9.0, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 9.16, stateContributionWeighted: 9.0 },
    { year: 2016, totalContribution: 10.69, totalContributionWeighted: 10.2, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 10.69, stateContributionWeighted: 10.2 },
    { year: 2017, totalContribution: 11.09, totalContributionWeighted: 10.8, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 11.09, stateContributionWeighted: 10.8 },
    { year: 2018, totalContribution: 11.36, totalContributionWeighted: 11.0, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 11.36, stateContributionWeighted: 11.0 },
    { year: 2019, totalContribution: 12.21, totalContributionWeighted: 11.8, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 12.21, stateContributionWeighted: 11.8 },
    { year: 2020, totalContribution: 13.83, totalContributionWeighted: 13.4, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 13.83, stateContributionWeighted: 13.4 },
    { year: 2021, totalContribution: 12.87, totalContributionWeighted: 12.6, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 12.87, stateContributionWeighted: 12.6 },
    { year: 2022, totalContribution: 14.10, totalContributionWeighted: 14.0, districtContribution: 0, districtContributionWeighted: 0, stateContribution: 14.10, stateContributionWeighted: 14.0 }
  ],
  'California': [
    { year: 2015, totalContribution: 4.87, totalContributionWeighted: 5.0, districtContribution: 3.2, districtContributionWeighted: 3.5, stateContribution: 1.67, stateContributionWeighted: 1.5 },
    { year: 2016, totalContribution: 5.63, totalContributionWeighted: 5.8, districtContribution: 3.8, districtContributionWeighted: 4.0, stateContribution: 1.83, stateContributionWeighted: 1.8 },
    { year: 2017, totalContribution: 6.48, totalContributionWeighted: 6.6, districtContribution: 4.4, districtContributionWeighted: 4.6, stateContribution: 2.08, stateContributionWeighted: 2.0 },
    { year: 2018, totalContribution: 7.23, totalContributionWeighted: 7.4, districtContribution: 4.8, districtContributionWeighted: 5.0, stateContribution: 2.43, stateContributionWeighted: 2.4 },
    { year: 2019, totalContribution: 8.00, totalContributionWeighted: 8.2, districtContribution: 5.2, districtContributionWeighted: 5.4, stateContribution: 2.80, stateContributionWeighted: 2.8 },
    { year: 2020, totalContribution: 8.66, totalContributionWeighted: 8.8, districtContribution: 5.6, districtContributionWeighted: 5.8, stateContribution: 3.06, stateContributionWeighted: 3.0 },
    { year: 2021, totalContribution: 8.10, totalContributionWeighted: 8.0, districtContribution: 5.0, districtContributionWeighted: 4.8, stateContribution: 3.10, stateContributionWeighted: 3.2 },
    { year: 2022, totalContribution: 8.23, totalContributionWeighted: 8.2, districtContribution: 5.0, districtContributionWeighted: 4.8, stateContribution: 3.23, stateContributionWeighted: 3.4 }
  ],
  'Georgia': [
    { year: 2015, totalContribution: 7.03, totalContributionWeighted: 7.0, districtContribution: 6.8, districtContributionWeighted: 6.8, stateContribution: 0.23, stateContributionWeighted: 0.2 },
    { year: 2016, totalContribution: 7.50, totalContributionWeighted: 7.4, districtContribution: 7.2, districtContributionWeighted: 7.2, stateContribution: 0.30, stateContributionWeighted: 0.2 },
    { year: 2017, totalContribution: 7.48, totalContributionWeighted: 7.4, districtContribution: 7.2, districtContributionWeighted: 7.2, stateContribution: 0.28, stateContributionWeighted: 0.2 },
    { year: 2018, totalContribution: 8.64, totalContributionWeighted: 8.6, districtContribution: 8.4, districtContributionWeighted: 8.4, stateContribution: 0.24, stateContributionWeighted: 0.2 },
    { year: 2019, totalContribution: 10.32, totalContributionWeighted: 10.2, districtContribution: 10.0, districtContributionWeighted: 10.0, stateContribution: 0.32, stateContributionWeighted: 0.2 },
    { year: 2020, totalContribution: 10.63, totalContributionWeighted: 10.4, districtContribution: 10.2, districtContributionWeighted: 10.2, stateContribution: 0.43, stateContributionWeighted: 0.2 },
    { year: 2021, totalContribution: 9.48, totalContributionWeighted: 9.4, districtContribution: 9.2, districtContributionWeighted: 9.2, stateContribution: 0.28, stateContributionWeighted: 0.2 },
    { year: 2022, totalContribution: 9.25, totalContributionWeighted: 9.2, districtContribution: 9.13, districtContributionWeighted: 9.1, stateContribution: 0.12, stateContributionWeighted: 0.1 }
  ],
  'Texas': [
    { year: 2015, totalContribution: 1.97, totalContributionWeighted: 2.0, districtContribution: 1.2, districtContributionWeighted: 1.2, stateContribution: 0.77, stateContributionWeighted: 0.8 },
    { year: 2016, totalContribution: 1.96, totalContributionWeighted: 2.0, districtContribution: 1.2, districtContributionWeighted: 1.2, stateContribution: 0.76, stateContributionWeighted: 0.8 },
    { year: 2017, totalContribution: 1.94, totalContributionWeighted: 2.0, districtContribution: 1.2, districtContributionWeighted: 1.2, stateContribution: 0.74, stateContributionWeighted: 0.8 },
    { year: 2018, totalContribution: 2.20, totalContributionWeighted: 2.2, districtContribution: 1.4, districtContributionWeighted: 1.4, stateContribution: 0.80, stateContributionWeighted: 0.8 },
    { year: 2019, totalContribution: 2.15, totalContributionWeighted: 2.2, districtContribution: 1.4, districtContributionWeighted: 1.4, stateContribution: 0.75, stateContributionWeighted: 0.8 },
    { year: 2020, totalContribution: 2.35, totalContributionWeighted: 2.4, districtContribution: 1.6, districtContributionWeighted: 1.6, stateContribution: 0.75, stateContributionWeighted: 0.8 },
    { year: 2021, totalContribution: 2.37, totalContributionWeighted: 2.4, districtContribution: 1.6, districtContributionWeighted: 1.6, stateContribution: 0.77, stateContributionWeighted: 0.8 },
    { year: 2022, totalContribution: 2.62, totalContributionWeighted: 2.6, districtContribution: 1.41, districtContributionWeighted: 1.4, stateContribution: 1.21, stateContributionWeighted: 1.2 }
  ],
  'Minnesota': [
    { year: 2015, totalContribution: 4.33, totalContributionWeighted: 4.4, districtContribution: 4.5, districtContributionWeighted: 4.6, stateContribution: -0.17, stateContributionWeighted: -0.2 },
    { year: 2016, totalContribution: 4.28, totalContributionWeighted: 4.3, districtContribution: 4.4, districtContributionWeighted: 4.5, stateContribution: -0.12, stateContributionWeighted: -0.2 },
    { year: 2017, totalContribution: 4.30, totalContributionWeighted: 4.4, districtContribution: 4.5, districtContributionWeighted: 4.6, stateContribution: -0.20, stateContributionWeighted: -0.2 },
    { year: 2018, totalContribution: 4.52, totalContributionWeighted: 4.6, districtContribution: 4.7, districtContributionWeighted: 4.8, stateContribution: -0.18, stateContributionWeighted: -0.2 },
    { year: 2019, totalContribution: 4.48, totalContributionWeighted: 4.5, districtContribution: 4.6, districtContributionWeighted: 4.7, stateContribution: -0.12, stateContributionWeighted: -0.2 },
    { year: 2020, totalContribution: 4.52, totalContributionWeighted: 4.6, districtContribution: 4.7, districtContributionWeighted: 4.8, stateContribution: -0.18, stateContributionWeighted: -0.2 },
    { year: 2021, totalContribution: 4.69, totalContributionWeighted: 4.7, districtContribution: 4.9, districtContributionWeighted: 5.0, stateContribution: -0.21, stateContributionWeighted: -0.3 },
    { year: 2022, totalContribution: 4.72, totalContributionWeighted: 4.7, districtContribution: 4.93, districtContributionWeighted: 4.9, stateContribution: -0.21, stateContributionWeighted: -0.2 }
  ],
  'Florida': [
    { year: 2015, totalContribution: 4.25, totalContributionWeighted: 4.2, districtContribution: 4.25, districtContributionWeighted: 4.2, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2016, totalContribution: 3.90, totalContributionWeighted: 3.9, districtContribution: 3.90, districtContributionWeighted: 3.9, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2017, totalContribution: 4.06, totalContributionWeighted: 4.1, districtContribution: 4.06, districtContributionWeighted: 4.1, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2018, totalContribution: 4.25, totalContributionWeighted: 4.2, districtContribution: 4.25, districtContributionWeighted: 4.2, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2019, totalContribution: 4.38, totalContributionWeighted: 4.4, districtContribution: 4.38, districtContributionWeighted: 4.4, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2020, totalContribution: 4.58, totalContributionWeighted: 4.6, districtContribution: 4.58, districtContributionWeighted: 4.6, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2021, totalContribution: 5.60, totalContributionWeighted: 5.6, districtContribution: 5.60, districtContributionWeighted: 5.6, stateContribution: 0, stateContributionWeighted: 0 },
    { year: 2022, totalContribution: 5.95, totalContributionWeighted: 5.9, districtContribution: 5.95, districtContributionWeighted: 5.9, stateContribution: 0, stateContributionWeighted: 0 }
  ]
};

export default function PensionContributionsChart() {
  const [selectedState, setSelectedState] = useState('Texas')

  const getYAxisDomain = (state: string) => {
    switch(state) {
      case 'Texas':
        return [0, 3];
      case 'Massachusetts':
        return [8, 16];
      case 'California':
        return [0, 10];
      case 'Georgia':
        return [0, 12];
      case 'Florida':
        return [2, 6.5];
      case 'Minnesota':
        return [0, 6];
      default:
        return [0, 15];
    }
  };

  return (
    <Card className="w-full">
      <CardHeader>
        <CardTitle>Pension Contributions as a Percentage of Education Expenditures (2015-2022)</CardTitle>
        <CardDescription>Detailed view for selected state</CardDescription>
        <Select value={selectedState} onValueChange={setSelectedState}>
          <SelectTrigger className="w-[200px]">
            <SelectValue placeholder="Select a state" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="Massachusetts">Massachusetts</SelectItem>
            <SelectItem value="California">California</SelectItem>
            <SelectItem value="Georgia">Georgia</SelectItem>
            <SelectItem value="Minnesota">Minnesota</SelectItem>
            <SelectItem value="Texas">Texas</SelectItem>
            <SelectItem value="Florida">Florida</SelectItem>
          </SelectContent>
        </Select>
        <Badge variant="outline" className="font-mono mt-2">
          {selectedState}
        </Badge>
      </CardHeader>
      <CardContent>
        <div className="h-[400px]">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart
              data={educationData[selectedState]}
              margin={{ top: 20, right: 30, left: 40, bottom: 20 }}
            >
              <CartesianGrid strokeDasharray="3 3" className="opacity-30" />
              <XAxis
                dataKey="year"
                tickLine={false}
                tick={{ fill: '#666' }}
              />
              <YAxis
                domain={getYAxisDomain(selectedState)}
                tickLine={false}
                tick={{ fill: '#666' }}
                label={{ value: 'Percent (%)', angle: -90, position: 'insideLeft', fill: '#666' }}
              />
              <Tooltip
                contentStyle={{
                  backgroundColor: 'white',
                  border: '1px solid #ccc',
                  borderRadius: '4px'
                }}
                formatter={(value: number) => [`${value.toFixed(2)}%`, '']}
              />
              <Legend />
              <Line
                type="linear"
                dataKey="totalContribution"
                stroke="#ff0000"
                strokeWidth={2}
                name="Total Contributions"
                dot={false}
                strokeDasharray="3 3"
              />
              <Line
                type="linear"
                dataKey="totalContributionWeighted"
                stroke="#ff0000"
                strokeWidth={2}
                name="Total Contributions (Weighted)"
                dot={false}
              />
              <Line
                type="linear"
                dataKey="districtContribution"
                stroke="#0088ff"
                strokeWidth={2}
                name="District Contributions"
                dot={false}
                strokeDasharray="3 3"
              />
              <Line
                type="linear"
                dataKey="districtContributionWeighted"
                stroke="#0088ff"
                strokeWidth={2}
                name="District Contributions (Weighted)"
                dot={false}
              />
              <Line
                type="linear"
                dataKey="stateContribution"
                stroke="#666666"
                strokeWidth={2}
                name="State Contributions"
                dot={false}
                strokeDasharray="3 3"
              />
              <Line
                type="linear"
                dataKey="stateContributionWeighted"
                stroke="#666666"
                strokeWidth={2}
                name="State Contributions (Weighted)"
                dot={false}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </CardContent>
    </Card>
  )
}

