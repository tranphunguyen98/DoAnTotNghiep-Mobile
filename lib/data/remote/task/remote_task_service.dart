import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/response/project_list_response.dart';
import 'package:totodo/data/response/project_response.dart';

part 'remote_task_service.g.dart';

@RestApi(baseUrl: "http://192.168.1.18:3006/")
abstract class RemoteTaskService {
  factory RemoteTaskService(Dio dio, {String baseUrl}) = _RemoteTaskService;

  @GET("/projects")
  Future<ProjectListResponse> getProjects(
    @Header("authorization") String authorization,
  );

  @POST('projects')
  Future<ProjectResponse> addProject(
    @Header("authorization") String authorization,
    @Field() String name,
    @Field() String color,
  );
}
