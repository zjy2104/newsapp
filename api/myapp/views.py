from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework import viewsets
from rest_framework.parsers import JSONParser
from myapp.serializers import NewsSerializer, CommentSerializer
from django.shortcuts import render
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from myapp.models import User, Comment, Sina
from django.http import HttpResponse
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.decorators import action
from rest_framework.response import Response


class new_list(viewsets.ModelViewSet):
    """
    List all code snippets, or create a new snippet.
    """
    queryset = Sina.objects.all()
    serializer_class = NewsSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["newid"]
    charset = 'utf-8'



class comment_list(viewsets.ModelViewSet):
    """
    List all code snippets, or create a new snippet.
    """
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ["count"]


def exercise(request):
    """
    List all code snippets, or create a new snippet.
    """
    if request.method == 'GET':
        snippets = Sina.objects.all()
        serializer = NewsSerializer(snippets, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = NewsSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)




def login(request):
    id = request.GET.get('id')
    username = request.GET.get('usernames')
    #userphone = request.GET.get('phonenum')
    userpassword = request.GET.get('okword')

    try:
        user = User.objects.get(name=username)
    except ObjectDoesNotExist:
        print("用户不存在")
        return HttpResponse("用户不存在")
    else:
        if user.okword == userpassword:
            print("登录成功")
            return HttpResponse("登陆成功")
        else:
            print("密码错误")
            return HttpResponse("密码错误")



def person(request):
    #id = request.GET.get('id')
    username = request.GET.get('usernames')
    #userphone = request.GET.get('phonenum')
    #userpassword = request.GET.get('okword')

    try:
        user = User.objects.get(name=username)
    except ObjectDoesNotExist:
        print("用户不存在")
        return HttpResponse("用户不存在")
    else:
        #if user.okword == userpassword:
            #print("登录成功")
        return HttpResponse(user.phone)
        #else:
            #print("密码错误")
            #return HttpResponse("密码错误")



def sign_up(request):
    id= request.GET.get('id')
    username = request.GET.get('usernames')
    userphone = request.GET.get('phonenum')
    userpassword = request.GET.get('okword')


    try:
        User.objects.get(name=username)
    except ObjectDoesNotExist:
        User.objects.create(id=id, name=username, phone=userphone, okword=userpassword)
        print("成功")
        return HttpResponse("成功")
    else:
        print("用户名重复")
        return HttpResponse("用户名重复")


def add_comment(request):
    count = request.GET.get('count')
    name_id = request.GET.get('name_id')
    comment = request.GET.get('comment')
    #userpassword = request.GET.get('okword')


    #try:
        #Comment.objects.get(count=count)
    #except ObjectDoesNotExist:

        #print("新闻不存在")
        #return HttpResponse("新闻不存在")
    #else:
    Comment.objects.create(count=count, name_id=name_id, comment=comment)
        #print("成功")
    return HttpResponse("成功")
