from rest_framework import serializers
from myapp.models import Sina, Comment


class NewsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sina
        fields = ['count', 'title', 'date', 'editor', 'url', 'content', 'newid']


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ['count', 'name_id', 'comment']

