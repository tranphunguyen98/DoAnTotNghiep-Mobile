import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/remote/response/label_list_response.dart';
import 'package:totodo/data/remote/response/label_response.dart';
import 'package:totodo/data/remote/response/message_response.dart';
import 'package:totodo/data/remote/response/project_list_response.dart';
import 'package:totodo/data/remote/response/project_response.dart';
import 'package:totodo/data/remote/response/section_response.dart';
import 'package:totodo/data/remote/response/task_list_response.dart';
import 'package:totodo/data/remote/response/task_response.dart';

part 'remote_task_service.g.dart';

@RestApi(baseUrl: "http://192.168.1.18:3006/")
abstract class RemoteTaskService {
  factory RemoteTaskService(Dio dio, {String baseUrl}) = _RemoteTaskService;

  @GET("/tasks")
  Future<TaskListResponse> getTasks(
    @Header("authorization") String authorization,
  );

  @GET("tasks/{taskId}")
  Future<TaskResponse> getTaskDetail(
      @Header("authorization") String authorization, @Path() String taskId);

  @MultiPart()
  @POST("/tasks")
  Future<TaskListResponse> addTask(
    @Header("authorization") String authorization,
    @Part(name: '_id') String id,
    @Part(name: 'name') String name,
    @Part(name: 'dueDate') String dueDate,
    @Part(name: 'crontabSchedule') String crontabSchedule,
    @Part(name: 'section') String section,
    @Part(name: 'projectId') String projectId,
    @Part(name: 'labelIds') String labelIds,
    @Part(name: 'checkList') String checkList,
    @Part(name: 'priority') int priority,
  );

  @MultiPart()
  @PUT("/tasks/{taskId}")
  Future<TaskResponse> updateTask(
    @Header("authorization") String authorization,
    @Path() String taskId,
    @Part(name: 'name') String name,
    @Part(name: 'dueDate') String dueDate,
    @Part(name: 'crontabSchedule') String crontabSchedule,
    @Part(name: 'section') String section,
    @Part(name: 'projectId') String projectId,
    @Part(name: 'labelIds') String labelIds,
    @Part(name: 'checkList') String checkList,
    @Part(name: 'priority') int priority,
    @Part(name: 'isCompleted') bool isCompleted,
    @Part(name: 'completedDate') String completedDate,
    @Part(name: 'attachmentInfos') String attachmentInfos,
  );

  @DELETE("/tasks/{taskId}")
  Future<MessageResponse> deleteTask(
    @Header("authorization") String authorization,
    @Path() String taskId,
  );

  @GET("/projects")
  Future<ProjectListResponse> getProjects(
    @Header("authorization") String authorization,
  );

  @POST('/projects')
  Future<ProjectResponse> addProject(
    @Header("authorization") String authorization,
    @Field() String name,
    @Field() String color,
  );

  @GET("/labels")
  Future<LabelListResponse> getLabels(
    @Header("authorization") String authorization,
  );

  @POST('/labels')
  Future<LabelResponse> addLabel(
    @Header("authorization") String authorization,
    @Field() String name,
    @Field() String color,
  );

  @POST("/projects/{projectId}/sections")
  Future<ListSectionResponse> addSection(
      @Header("authorization") String authorization,
      @Path() String projectId,
      @Field() String name);
}
