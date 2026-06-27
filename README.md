# Финальный проект 2 семестра

[![Sausage Store Deploy](https://github.com/Mishamancik/cloud-services-engineer-sausage-store-project-sem2/actions/workflows/deploy.yaml/badge.svg)](https://github.com/Mishamancik/cloud-services-engineer-sausage-store-project-sem2/actions/workflows/deploy.yaml)

[Страница приложения](https://front-mikhail.2sem.students-projects.ru)

## Результаты деплоя

### Статус Helm-релиза
```bash
mikhail@study:~/projects/FinalProject/sausage_store$ helm list
NAME            NAMESPACE                                       REVISION        UPDATED                                 STATUS          CHART                APP VERSION
sausage-store   r-devops-magistracy-project-2sem-2212707331     7               2026-06-27 12:19:20.692630432 +0000 UTC deployed        sausage-store-0.1.5        latest
```

### Ресурсы в кластере (pods, ingress, HPA, VPA)
```bash
mikhail@study:~/projects/FinalProject/sausage_store$ kubectl get pods,ingress,hpa,vpa
NAME                                                READY   STATUS    RESTARTS   AGE
pod/mongodb-0                                       1/1     Running   0          106m
pod/postgresql-0                                    1/1     Running   0          107m
pod/sausage-store-backend-677586bfcb-rwt8b          1/1     Running   0          68m
pod/sausage-store-backend-report-787f8bfb9f-m26ps   1/1     Running   0          93m
pod/sausage-store-frontend-86bd955fb5-njxcb         1/1     Running   0          107m

NAME                                                       CLASS   HOSTS                                     ADDRESS          PORTS     AGE
ingress.networking.k8s.io/sausage-store-frontend-ingress   nginx   front-mikhail.2sem.students-projects.ru   158.160.176.69   80, 443   135m

NAME                                                                   REFERENCE                                 TARGETS       MINPODS   MAXPODSREPLICAS   AGE
horizontalpodautoscaler.autoscaling/sausage-store-backend-report-hpa   Deployment/sausage-store-backend-report   cpu: 2%/75%   1         21          135m

NAME                                                                 MODE   CPU   MEM       PROVIDED   AGE
verticalpodautoscaler.autoscaling.k8s.io/sausage-store-backend-vpa   Off    25m   262144k   True       135m
```

## Масштабирование

### Проверка HPA
```bash
mikhail@study:~/projects/FinalProject/sausage_store$ kubectl describe hpa
Name:                                                  sausage-store-backend-report-hpa
Namespace:                                             r-devops-magistracy-project-2sem-2212707331
Labels:                                                app.kubernetes.io/managed-by=Helm
Annotations:                                           meta.helm.sh/release-name: sausage-store
                                                       meta.helm.sh/release-namespace: r-devops-magistracy-project-2sem-2212707331
CreationTimestamp:                                     Sat, 27 Jun 2026 13:27:21 +0300
Reference:                                             Deployment/sausage-store-backend-report
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  2% (1m) / 75%
Min replicas:                                          1
Max replicas:                                          2
Deployment pods:                                       1 current / 1 desired
Conditions:
  Type            Status  Reason              Message
  ----            ------  ------              -------
  AbleToScale     True    ReadyForNewScale    recommended size matches current size
  ScalingActive   True    ValidMetricFound    the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  False   DesiredWithinRange  the desired count is within the acceptable range
Events:           <none>
```

### Проверка VPA
```bash
mikhail@study:~/projects/FinalProject/sausage_store$ kubectl describe vpa
Name:         sausage-store-backend-vpa
Namespace:    r-devops-magistracy-project-2sem-2212707331
Labels:       app.kubernetes.io/managed-by=Helm
Annotations:  meta.helm.sh/release-name: sausage-store
              meta.helm.sh/release-namespace: r-devops-magistracy-project-2sem-2212707331
API Version:  autoscaling.k8s.io/v1
Kind:         VerticalPodAutoscaler
Metadata:
  Creation Timestamp:  2026-06-27T10:27:21Z
  Generation:          1
  Resource Version:    305682745
  UID:                 7125ac28-66ec-4c24-a9ed-b4bbcea5a7c8
Spec:
  Resource Policy:
    Container Policies:
      Container Name:  backend
      Controlled Resources:
        cpu
        memory
  Target Ref:
    API Version:  apps/v1
    Kind:         Deployment
    Name:         sausage-store-backend
  Update Policy:
    Update Mode:  Off
Status:
  Conditions:
    Last Transition Time:  2026-06-27T10:28:13Z
    Status:                True
    Type:                  RecommendationProvided
  Recommendation:
    Container Recommendations:
      Container Name:  backend
      Lower Bound:
        Cpu:     25m
        Memory:  262144k
      Target:
        Cpu:     25m
        Memory:  262144k
      Uncapped Target:
        Cpu:     25m
        Memory:  262144k
      Upper Bound:
        Cpu:     6086m
        Memory:  3346089487
Events:          <none>
```


--- 
# Sausage Reporter

## Installation

1. Install `Golang`
2. Set environment variables `PORT` and `DB`
3. Run `go run main.go`

Example: `PORT=8080 DB=mongodb://localhost:27017/reports go run main.go`

## Health endpoint

Application exposes `/api/v1/health` endpoint according to the 12-factors app

## Testing

Run unit tests via `go test ./app/services/health`

## Local run with docker and local mongoDB

```bash
docker build -t sausage-reporter .
docker run -d --name mongo -p 27017:27017 mongo
docker run --name sausage-reporter -ti -e PORT=8080 -e DB=mongodb://host.docker.internal:27017/reports -p 8080:8080 sausage-reporter
```
