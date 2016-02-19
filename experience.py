#!/usr/local/bin/python3
import pandas as pd
import seaborn as sns
import numpy as np

data_raw = pd.read_csv('data/survey_new.csv')

import matplotlib.pyplot as plt

df = pd.read_csv('data/survey_new.csv')

data_1 = {'Yes':[90, 86, 41, 56, 79, 18, 25, 36, 14, 39], 'No':[24, 28, 73, 58, 35, 96, 89, 78, 100, 75]}
df_1 = pd.DataFrame(data_1)


df_1 = pd.DataFrame(data_1, index = ['R', 'Python','Shell', 'SQL' , 'Excel', 'Stata', 'HTML', 'C/C++', 'SPSS', 'Matlab'])


fig = plt.figure()
dft = df_1.sort_index(by = 'Yes')
df_plot = dft.plot(kind = 'barh', fontsize = 'large')
df_plot.set_title('Number of Students for Each Tool Used in the Class', fontsize = 'large')
df_plot.set_xlabel('Number of Students', fontsize = 'large')
df_plot.legend(loc = 'best', fontsize = 'large')
fig = df_plot.get_figure()
fig.savefig('plots/output_total.png')
fig.set_size_inches(12, 12, forward=True)


df_2 = df.ix[df.R]
df_3 = df.ix[df.R == False]
pd.value_counts(df_3.Program).plot(kind = 'barh')


df_4 = df.ix[df.Python]
df_5 = df.ix[df.Python == False]
pd.value_counts(df_4.Program).plot(kind = 'barh')


df_6 = df.ix[df['C/C++']]
df_7 = df.ix[df['C/C++'] == False]
pd.value_counts(df_6.Program).plot(kind = 'barh')


data_github = {'C/C++':[0.167, 0.417, 0.387, 0.028], 'R':[0.322, 0.378, 0.278, 0.022], 'Python':[0.302, 0.360, 0.314, 0.023]}
df_github = pd.DataFrame(data_github, columns = ['C/C++', 'R', 'Python'], index = ['None', 'Little', 'Confident', 'Expert'])


fig = plt.figure()

github_plot = df_github.plot(kind = 'barh', fontsize= 'medium')
github_plot.legend(loc = 'best', fontsize = 'large')
github_plot.set_title('Experience in Github versus Programming Language', fontsize = 'large')
fig = github_plot.get_figure()
fig.savefig('plots/output_github.png')
fig.set_size_inches(12, 12, forward=True)


data_matlab = {'C/C++':[0.222, 0.444, 0.305, 0.028], 'R':[0.356, 0.389, 0.244, 0.011], 'Python':[0.372, 0.372, 0.244, 0.012]}
df_matlab = pd.DataFrame(data_matlab, columns = ['C/C++', 'R', 'Python'], index = ['None', 'Little', 'Confident', 'Expert'])


fig = plt.figure()

matlab_plot = df_matlab.plot(kind = 'barh', fontsize= 'medium')
matlab_plot.legend(loc = 'best', fontsize = 'large')
matlab_plot.set_title('Experience in Matlab versus Programming Language', fontsize = 'large')
fig = matlab_plot.get_figure()
fig.savefig('plots/output_matlab.png')
fig.set_size_inches(12, 12, forward=True)


data_multivariate = {'C/C++':[0.194, 0.500, 0.278, 0.028], 'R':[0.178, 0.556, 0.244, 0.022], 'Python':[0.279, 0.500, 0.198, 0.023]}
df_multivariate = pd.DataFrame(data_multivariate, columns = ['C/C++', 'R', 'Python'], index = ['None', 'Little', 'Confident', 'Expert'])


fig = plt.figure()


multivariate_plot = df_multivariate.plot(kind = 'barh', fontsize= 'medium')
multivariate_plot.legend(loc = 'best', fontsize = 'large')
multivariate_plot.set_title('Experience in Multivariate Analysis versus Programming Language', fontsize = 'large')
fig = multivariate_plot.get_figure()
fig.savefig('plots/output_multivariate.png')
fig.set_size_inches(12, 12, forward=True)


data_manipulation = {'C/C++':[0.083, 0.194, 0.583, 0.139], 'R':[0, 0.255, 0.622, 0.122], 'Python':[0.082, 0.267, 0.558, 0.093]}
df_manipulation= pd.DataFrame(data_manipulation, columns = ['C/C++', 'R', 'Python'], index = ['None', 'Little', 'Confident', 'Expert'])


fig = plt.figure()

manipulation_plot = df_manipulation.plot(kind = 'barh', fontsize= 'medium')
manipulation_plot.legend(loc = 'best', fontsize = 'large')
manipulation_plot.set_title('Experience in Data Manipulation and Modeling versus Programming Language', fontsize = 'large')
fig = manipulation_plot.get_figure()
fig.savefig('plots/output_manipulation.png')
fig.set_size_inches(12, 12, forward=True)



data_graph= {'C/C++':[0.222, 0.278, 0.472, 0.028], 'R':[0.089, 0.522, 0.367, 0.022], 'Python':[0.209, 0.442, 0.337, 0.012]}
df_graph= pd.DataFrame(data_graph, columns = ['C/C++', 'R', 'Python'], index = ['None', 'Little', 'Confident', 'Expert'])



fig = plt.figure()

graph_plot = df_graph.plot(kind = 'barh', fontsize= 'medium')
graph_plot.legend(loc = 'best', fontsize = 'large')
graph_plot.set_title('Experience in R Graph and Visualization versus Programming Language', fontsize = 'large')
fig = graph_plot.get_figure()
fig.savefig('plots/output_graph.png')
fig.set_size_inches(12, 12, forward=True)

data_markdown= {'C/C++':[0.278, 0.417, 0.222, 0.083], 'R':[0.322, 0.344, 0.267, 0.067], 'Python':[0.337, 0.349, 0.244, 0.070]}
df_markdown= pd.DataFrame(data_markdown, columns = ['C/C++', 'R', 'Python'], index = ['None', 'Little', 'Confident', 'Expert'])


fig = plt.figure()

markdown_plot = df_markdown.plot(kind = 'barh', fontsize= 'medium')
markdown_plot.legend(loc = 'best', fontsize = 'large')
markdown_plot.set_title('Experience in R Markdown versus Programming Language', fontsize = 'large')
fig = markdown_plot.get_figure()
fig.savefig('plots/output_markdown.png')
fig.set_size_inches(12, 12, forward=True)


data_cpp= {'None':[0.167, 0.222, 0.194, 0.083, 0.222, 0.278], 'Little':[0.417, 0.444, 0.500, 0.194, 0.278, 0.417], 'Confident':[0.389, 0.305, 0.278, 0.583, 0.472, 0.222], 'Expert':[0.028, 0.028, 0.028, 0.139, 0.028, 0.083]}
df_cpp = pd.DataFrame(data_cpp, columns = ['None', 'Little', 'Confident', 'Expert' ], index = ['Github', 'Matlab', 'Analytics', 'Manipulation', 'Graph', 'Markdown'])


fig = plt.figure()

cpp_plot = df_cpp.plot(kind = 'barh', fontsize= 'medium')
cpp_plot.legend(loc = 'best', fontsize = 'large')
cpp_plot.set_title('Experience in Different Skills of Students Using C/C++', fontsize = 'large')
fig.subplots_adjust(hspace = 100, wspace = 100)
fig = cpp_plot.get_figure()
fig.savefig('plots/output_cpp.png')
fig.set_size_inches(12, 12, forward=True)


data_r= {'None':[0.322, 0.356, 0.178, 0.0, 0.089, 0.322], 'Little':[0.378, 0.389, 0.556, 0.255, 0.522, 0.344], 'Confident':[0.278, 0.244, 0.244, 0.622, 0.367, 0.267], 'Expert':[0.022, 0.011, 0.022, 0.122, 0.022, 0.067]}
df_r = pd.DataFrame(data_r, columns = ['None', 'Little', 'Confident', 'Expert' ], index = ['Github', 'Matlab', 'Analytics', 'Manipulate', 'Graph', 'Markdown'])


fig = plt.figure()

r_plot = df_r.plot(kind = 'barh', fontsize= 'medium')
r_plot.legend(loc = 'best', fontsize = 'large')
r_plot.set_title('Experience in Different Skills of Students Using R', fontsize = 'large')
fig.subplots_adjust(hspace = 100, wspace = 100)
fig = r_plot.get_figure()
fig.savefig('plots/output_r.png')
fig.set_size_inches(12, 12, forward=True)


data_python= {'None':[0.302, 0.372, 0.279, 0.081, 0.209, 0.337], 'Little':[0.360, 0.372, 0.500, 0.267, 0.442, 0.349], 'Confident':[0.314, 0.244, 0.198, 0.558, 0.337, 0.244], 'Expert':[0.023, 0.012, 0.023, 0.093, 0.012, 0.070]}
df_python = pd.DataFrame(data_python, columns = ['None', 'Little', 'Confident', 'Expert' ], index = ['Github', 'Matlab', 'Analytics', 'Manipulate', 'Graph', 'Markdown'])


fig = plt.figure()

python_plot = df_python.plot(kind = 'barh', fontsize= 'medium')
python_plot.legend(loc = 'best', fontsize = 'large')
python_plot.set_title('Experience in Different Skills of Students Using Python', fontsize = 'large')
fig = python_plot.get_figure()
fig.subplots_adjust(hspace = 100, wspace = 100)
fig.savefig('plots/output_python.png')
fig.set_size_inches(20, 20, forward=True)
