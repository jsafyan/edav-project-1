#!/usr/local/bin/python3
import pandas as pd
import seaborn as sns
import numpy as np

import matplotlib.pyplot as plt

def main():
	df = pd.read_csv('data/survey_new.csv')
	plt.style.use("ggplot")

	cols = ['Program','R', 'Excel', 'SQL', 'RStudio', 'ggplot2', 'Python', 'Stata', 'dropbox',
	'google drive (formerly docs)', 'regular expressions (grep)', 'Github',
	'shell (terminal / command line)', 'LaTeX', 'Sweave/knitr', 'XML',
	'Web: html css js', 'C/C++', 'Matlab', 'SPSS', 'lattice']


	tool_names = ['R', 'Excel', 'SQL',
	'RStudio', 'ggplot2', 'Python', 'Stata', 'dropbox',
	'google drive (formerly docs)', 'regular expressions (grep)', 'Github',
	'shell (terminal / command line)', 'LaTeX', 'Sweave/knitr', 'XML',
	'Web: html css js', 'C/C++', 'Matlab', 'SPSS', 'lattice']

	tools = df[cols]

	# Cast the tool boolean values as 0 or 1 to compute the correlation matrix
	for name in tool_names:
		tools[name] = tools[name].apply(int)

	# Tool correlation matrix
	corr = tools.corr()

	# Generate a mask for the upper triangle
	mask = np.zeros_like(corr, dtype=np.bool)
	mask[np.triu_indices_from(mask)] = True

	# Set up matplotlib figure and axis
	fig, ax = plt.subplots(figsize=(16, 12))

	# Diverging colormap
	cmap = sns.diverging_palette(220, 10, as_cmap=True)

	ax.set_title('Correlation of tool use by all students')

	# Create the seaborn heatmap with the upper triangle masked
	heatmap = sns.heatmap(corr, annot=True, mask=mask, cmap=cmap, vmax=1,
		linewidths=.5, cbar_kws={"shrink": .5}, ax=ax)
	# Make the axis labels legible
	plt.yticks(rotation=360)
	plt.xticks(rotation=90)
	# Save the plot
	plt.savefig("tool_heatmap.png")


if __name__ == '__main__':
	main()



