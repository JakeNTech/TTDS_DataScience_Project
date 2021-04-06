# Real-Time Data collection and monitoring
# Level 5 TTDS
# 2021
import pandas as pd
from pandas import Timestamp
from datetime import datetime, timedelta
import numpy as np
import matplotlib.pyplot as plt
import os
from scipy import stats

def collect_data(number):
    yesterday = (datetime.now() - timedelta(1)).strftime('%Y/%m/%d')
    command = "rwfilter --sensor=S0 --proto=0-255 --start-date=%s --type=all --all=stdout | rwcount --bin-size=300 --delim=',' > ./Data/%s.csv" % (yesterday,number)
    os.system(command)
def graph_plot(x,y):
    # Bytes Over Time
    plt.plot(x,y,label="Actual Data")
    for i in range(1,5):
        poly = np.poly1d(np.polyfit(x,y,i))
        new_x = np.linspace(df_time[0],df_time[-1])
        new_y = poly(new_x)
        plt.plot(new_x, new_y,label="Polynomial %i" %i)
    #plt.ylim(bottom=0)
    plt.xlabel('Time')
    plt.ylabel('Bytes')
    plt.legend(title="Legend")
    plt.savefig('./graphs/output.png')
def predict(path,prediction_time):
    df = pd.read_csv(path,delimiter=",")
    y = df["Bytes"].to_numpy()
    X = list(range(0,len(y)))
    slope, intercept, r, p, std_err = stats.linregress(X, y)
    print(f"Prediction: {(slope*prediction_time+intercept)/1000000} Megabytes at Timestamp {prediction_time}")

if __name__ == "__main__":
    collect_data("1")
    predict("./Date/1.csv",50)