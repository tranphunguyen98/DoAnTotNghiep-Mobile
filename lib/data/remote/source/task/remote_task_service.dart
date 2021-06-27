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

  @POST("/tasks")
  Future<TaskListResponse> addTask(
    @Header("authorization") String authorization,
    @Body() Map<String, dynamic> body,
  );

  @PUT("/tasks/{taskId}")
  Future<TaskResponse> updateTask(@Header("authorization") String authorization,
      @Path() String taskId, @Body() Map<String, dynamic> body);

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