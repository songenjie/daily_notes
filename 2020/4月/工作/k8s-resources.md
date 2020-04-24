          resources:
            limits:
              cpu: 2
              memory: 4Gi
            requests:
              cpu: "500m"
              memory: 500Mi

          volumeMounts:
          - mountPath: /opt/conf
            name: configmap

      - configMap:
          name: ***
        name: configmap
