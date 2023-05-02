[1mdiff --git a/.github/workflows/push.yaml b/.github/workflows/push.yaml[m
[1mindex 30eff1b..246dd71 100644[m
[1m--- a/.github/workflows/push.yaml[m
[1m+++ b/.github/workflows/push.yaml[m
[36m@@ -25,7 +25,7 @@[m [mjobs:[m
         run: |[m
           make Dockerfile[m
           echo 'TAGS<<EOF' >> $GITHUB_OUTPUT[m
[31m-          [7m[27minfoblox/helm:$(make version),infoblox/helm:$(make version-major) >> $GITHUB_OUTPUT[m
[32m+[m[32m          [7m@echo [27minfoblox/helm:$(make version),infoblox/helm:$(make version-major) >> $GITHUB_OUTPUT[m
           echo 'EOF' >> $GITHUB_OUTPUT[m
       - name: Build and push[m
         uses: docker/build-push-action@v3[m
