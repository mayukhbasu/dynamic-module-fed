
AWS deployment
docker tag login-image:v1 253490776807.dkr.ecr.us-east-1.amazonaws.com/login-image:v1
docker tag dashboard-image:v1 253490776807.dkr.ecr.us-east-1.amazonaws.com/dashboard-image:v1

docker push 253490776807.dkr.ecr.us-east-1.amazonaws.com/dashboard-image:v1
docker push 253490776807.dkr.ecr.us-east-1.amazonaws.com/login-image:v1

docker buildx build --platform linux/amd64,linux/arm64 -t 253490776807.dkr.ecr.us-east-1.amazonaws.com/dashboard-image:v2 -f apps/dashboard/Dockerfile.dashboard --push .

docker buildx build --platform linux/amd64,linux/arm64 -t 253490776807.dkr.ecr.us-east-1.amazonaws.com/login-image:v2 -f apps/login/Dockerfile.login --push .

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 253490776807.dkr.ecr.us-east-1.amazonaws.com

Normal Deployment


