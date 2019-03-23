# Generic Helm Chart

This is a very basic Helm Chart template for getting a very simple service up and running in Kubernetes. It deploys:

* The Nginx-Ingress chart (Providing your values for the Nginx-Ingress chart is beyond the scope of this README)
* Docker authorization secret that pulls & base64 encodes Docker repository credential information from your Values file
* TLS certificate Secret that base64 encodes a provided SSL certificate and key
* Deployment that defaults to 2 pods
* Service that defaults to port 80
* Ingress resource to map HTTPS traffic to the Service at the URL provided in your Values file
* Network Policy that allows ingress HTTP & HTTPS traffic and denies all egress traffic
* Horizontal Pod Autoscaler that by default allows scaling up to 5 pods based on CPU utilization (scaling at 50% pod cpu utilization)

By providing reasonable values in your values file, and assuming a simple, single-port containerized application, this chart will deploy that application to Kubernetes. As long as you properly configure your Nginx-Ingress, you'll also be able to access that application externally at your provided URL.