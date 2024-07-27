from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import SumSerializer

class SumView(APIView):
    def post(self, request, format=None):
        serializer = SumSerializer(data=request.data)
        if serializer.is_valid():
            num1 = serializer.validated_data['num1']
            num2 = serializer.validated_data['num2']
            result = num1 + num2
            return Response({'result': result}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
