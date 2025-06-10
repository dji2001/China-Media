import pandas as pd
import plotly.graph_objects as go
from pathlib import Path

# === Step 1: Load Excel file from parent directory ===
input_file = Path("..") / "Foreign Coverage by Country.xlsx"
df = pd.read_excel(input_file, sheet_name="PD Coverage")

# === Step 2: Prepare data ===
plot_df = df[['country', 'year', 'article_count', 'artico_ratio']].dropna(subset=['year', 'article_count', 'artico_ratio'])
plot_df['year'] = plot_df['year'].astype(int)
country_list = plot_df['country'].unique()

# === Step 3: Create interactive plot ===
fig = go.Figure()

# Default variable: article_count
for country in country_list:
    country_data = plot_df[plot_df['country'] == country]
    fig.add_trace(go.Scatter(
        x=country_data['year'],
        y=country_data['article_count'],
        mode='lines',
        name=country
    ))

# Dropdown to switch between article_count and artico_ratio
variable_dropdown = [
    dict(label='Article Count',
         method='update',
         args=[{'y': [plot_df[plot_df['country'] == c]['article_count'] for c in country_list]},
               {'yaxis': {'title': 'Article Count'}}]),
    dict(label='Article Ratio',
         method='update',
         args=[{'y': [plot_df[plot_df['country'] == c]['artico_ratio'] for c in country_list]},
               {'yaxis': {'title': 'Article Ratio'}}])
]

# Layout and interactive slider
fig.update_layout(
    title='Foreign Coverage by Country in People\'s Daily',
    xaxis_title='Year',
    yaxis_title='Article Count',
    updatemenus=[
        dict(
            buttons=variable_dropdown,
            direction='down',
            showactive=True,
            x=0.0,
            xanchor='left',
            y=1.15,
            yanchor='top'
        )
    ],
    xaxis=dict(
        rangeslider=dict(visible=True),
        type='linear'
    ),
    height=600
)

# === Step 4: Export to HTML ===
output_file = Path("foreign_coverage_interactive.html")
fig.write_html(str(output_file))
print(f"Interactive plot saved to {output_file.resolve()}")
