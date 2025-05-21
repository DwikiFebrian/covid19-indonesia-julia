# COVID-19 Data Analysis with Julia

📊 Data analysis and visualization of COVID-19 cases in Indonesia using Julia. Includes data filtering, plotting, and animated trends with Plots.jl.

## Features

- **Data Loading**: Reads COVID-19 data from a CSV file into a DataFrame.
- **Data Filtering**: Filters data for specific countries (e.g., Indonesia).
- **Visualization**: Uses the `Plots` package to create static and animated plots.
- **Animation**: Generates a GIF showing the progression of COVID-19 cases over time.

## Packages Used

- `CSV`, `DataFrames`: For data manipulation.
- `Plots`: For creating visualizations.
- `Interact`: For interactive elements (though not fully demonstrated in the provided code).

## Example Output

An animated GIF (`kasus_indo.gif`) is generated to visualize the trend of COVID-19 cases in Indonesia over time.

## Usage

1. Ensure Julia and the required packages are installed.
2. Load the data: `df = CSV.read("covid_data.csv", DataFrame)`.
3. Filter data for a specific country: `filtered_df = df[df.country .== "Indonesia", :]`.
4. Generate plots or animations using the `Plots` package.

## Notes

- The provided code snippets are partial; adapt paths and data as needed.
- The project is intended for educational purposes and demonstrates basic Julia functionality for data analysis.
