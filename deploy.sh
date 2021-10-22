docker build -t sergeyn0vik/multi-client:latest -t sergeyn0vik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sergeyn0vik/multi-server:latest -t sergeyn0vik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sergeyn0vik/multi-worker:latest -t sergeyn0vik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sergeyn0vik/multi-client:latest
docker push sergeyn0vik/multi-server:latest
docker push sergeyn0vik/multi-worker:latest

docker push sergeyn0vik/multi-client:$SHA
docker push sergeyn0vik/multi-server:$SHA
docker push sergeyn0vik/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sergeyn0vik/multi-server:$SHA
kubectl set image deployments/client-deployment client=sergeyn0vik/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sergeyn0vik/multi-worker:$SHA