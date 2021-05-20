class ProjectProcessModel {
  String projectName; //项目名称
  String workPosition; //工程部位
  String componentName; //构件名称
  String componentCode; //构件编号
  String componentState; //构件状态
  String startTime; //开始时间
  String description; //施工描述

  ProjectProcessModel(
      {this.projectName,
      this.workPosition,
      this.componentName,
      this.componentCode,
      this.componentState,
      this.startTime,
      this.description});
}
