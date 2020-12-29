docker build -t kacperkwiatkowski/fibonacci_docker-client:latest -t kacperkwiatkowski/fibonacci_docker:$SHA -f ./client/Dockerfile ./client
docker build -t kacperkwiatkowski/fibonacci_docker-server:latest -t kacperkwiatkowski/fibonacci_docker:$SHA -f ./server/Dockerfile ./server
docker build -t kacperkwiatkowski/fibonacci_docker-worker:latest -t kacperkwiatkowski/fibonacci_docker:$SHA -f ./worker/Dockerfile ./worker

docker push kacperkwiatkowski/fibonacci_docker-client:latest
docker push kacperkwiatkowski/fibonacci_docker-server:latest
docker push kacperkwiatkowski/fibonacci_docker-worker:latest

docker push kacperkwiatkowski/fibonacci_docker-client:$SHA
docker push kacperkwiatkowski/fibonacci_docker-server:$SHA
docker push kacperkwiatkowski/fibonacci_docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kacperkwiatkowski/fibonacci_docker-server:$SHA
kubectl set image deployments/client-deployment client=kacperkwiatkowski/fibonacci_docker-client:$SHA
kubectl set image deployments/worker-deployment worker=kacperkwiatkowski/fibonacci_docker-worker:$SHA
