let project = new Project('Mr.Virus');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('rice2d');
project.addParameter('scripts');
project.addParameter("--macro keep('scripts')");
resolve(project);