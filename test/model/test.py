import numpy as np                                       ## 기초 수학 연산 및 행렬계산
import pandas as pd                                      ## 데이터프레임 사용
from sklearn import datasets                             ## iris와 같은 내장 데이터 사용
from sklearn.model_selection import train_test_split     ## train, test 데이터 분할

from sklearn.linear_model import LinearRegression        ## 선형 회귀분석
from sklearn.linear_model import LogisticRegression      ## 로지스틱 회귀분석
from sklearn.naive_bayes import GaussianNB               ## 나이브 베이즈
from sklearn import svm                                  ## 서포트 벡터 머신
from sklearn import tree                                 ## 의사결정나무
from sklearn.ensemble import RandomForestClassifier      ## 랜덤포레스트
from sklearn.metrics import accuracy_score               ## 정확도 평가를 위함

import matplotlib.pyplot as plt                          ## plot 그릴때 사용

# 가상데이터를 만들기 위한 라이브러리
from sklearn.datasets import make_classification

# 혹은 그냥 있는 데이터를 사용해도 됨

if __name__ == "__main__" :
    raw = datasets.load_breast_cancer()
    print("raw안에 들어있는 데이터의 s종류")
    print(raw.keys(), end="\n\n")

    print(raw["target_names"])

    print("data의 shape(행, 열)")
    print(raw["data"].shape, end="\n\n")

    print("feature_names의 shape(행, 열)")
    print(raw["feature_names"], end="\n\n")

    # data는 raw.data를
    data = pd.DataFrame(raw["data"])
    # target은 raw.target을
    target = pd.DataFrame(raw["target"])

    # 둘을 합쳐서 rawData로 만듬
    rawData = pd.concat([data, target], axis = 1)
    '''
pd.concat(objs,
        axis=0, # 0: 위+아래로 합치기, 1: 왼쪽+오른쪽으로 합치기
        join='outer', # 'outer': 합집합(union), 'inner': 교집합(intersection)
        ignore_index=False,  # False: 기존 index 유지, True: 기존 index 무시
        keys=None, # 계층적 index 사용하려면 keys 튜플 입력
        levels=None, 
        names=None, # index의 이름 부여하려면 names 튜플 입력fㅇ
        verify_integrity=False, # True: index 중복 확인
        copy=True) # 복사
    '''

    # column에 이름 주기
    rawData.columns = np.append(raw["feature_names"], np.array(["cancer"]), axis = 0)
    
    # data에 Column이 너무 많으므로, 2개만 뽑아내기
    dataX = rawData[['mean radius', 'mean texture']]
    dataY = rawData['cancer']

    print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 뽑아진 데이터 확인 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
    print(dataX)
    print(dataY)

    # 테스트 데이터와 트레이닝 데이터를 분리
    trainX, testX, trainY, testY = train_test_split(dataX, dataY, test_size = 0.1)

    model = LinearRegression()
    model.fit(trainX, trainY)