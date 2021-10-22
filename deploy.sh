docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sergeyn0vik/multi-server:latest -t sergeyn0vik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push stephengrider/multi-client:latest
docker push sergeyn0vik/multi-server:latest
docker push stephengrider/multi-worker:latest

docker push stephengrider/multi-client:$SHA
docker push sergeyn0vik/multi-server:$SHA
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deploymnet server=sergeyn0vik/multi-server:$SHA
kubectl set image deployments/client-deploymnet client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deploymnet worker=stephengrider/multi-worker:$SHA