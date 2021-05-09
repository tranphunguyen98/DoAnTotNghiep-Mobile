import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:totodo/data/response/project_response.dart';
import 'package:totodo/utils/util.dart';

part 'remote_task_service.g.dart';

@RestApi(baseUrl: "https://personal-task-management-be.herokuapp.com/")
abstract class RemoteTaskService {
  factory RemoteTaskService(Dio dio, {String baseUrl}) = _RemoteTaskService;

  @GET("/projects")
  Future<ProjectResponse> getProjects(
    @Header("authorization") String authorization,
  );
}
