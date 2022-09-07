# 怀旧服镇派

## Usage

```javascript
// install
npm i --save @jx3box/jx3box-talent2

// in component
import TalentRender from '@jx3box/jx3box-talent2/src/RenderTalent2.vue'
```

props

- talentCode

  example

  ```json
  {"version":"v20210719","xf":"冰心诀","sq":"0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000"}
  ```

## Dev
http://localhost:5000/?code=eyJ2ZXJzaW9uIjoidjIwMjEwODE0IiwieGYiOiLlgrLooYDmiJjmhI8iLCJzcSI6IjEzMjAsMDIxMiwyMTExLDIyMjAsMDIxMCwwMTAwLDIxMzAsMTAwMCwwMDAwLDAwMDAsMDAwMCwwMDAwIn0=


## Deploy
+ CDN刷新 https://oss.jx3box.com/static/jx3box-talent2/ 目录


# 部署流程
+ 更新版本号
+ 构建发布完Npm包后
+ 更新app库对此库的依赖并部署
+ 更新macro库对此库的依赖并部署
+ 更新pz库对此库的依赖并部署

