object @auth
  extends "users/_user"
  glue :api_key,  object_root: false do     
    extends "api_keys/_api_key" 
  end
