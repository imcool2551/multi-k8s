docker build -t imcool2551/multi-client:latest -t imcool2551/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t imcool2551/multi-server -t imcool2551/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t imcool2551/multi-worker -t imcool2551/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push imcool2551/multi-client:latest
docker push imcool2551/multi-client:$SHA
docker push imcool2551/multi-server:latest
docker push imcool2551/multi-server:$SHA
docker push imcool2551/multi-worker:latest
docker push imcool2551/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=imcool2551/multi-client:$SHA
kubectl set image deployments/server-deployment server=imcool2551/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=imcool2551/multi-worker:$SHA

# Create secret using gcloud-shell