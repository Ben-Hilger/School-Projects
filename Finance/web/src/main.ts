import container from './config/inversify/inversify.config'
import TYPES from '@/config/inversify/types'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import '@/assets/main.css'
import type IApiService from '@/service/api/IApiService'
import FirebaseConfig from '@/config/firebase/FirebaseConfig'
import type IAuthService from './service/auth/IAuthService'
import type IFormatter from './service/formatter/IFormatter'
import type IUserService from './service/user/IUserService'

const app = createApp(App)

FirebaseConfig.getConfig().init()

app.provide('$apiService', container.get<IApiService>(TYPES.APIService))
app.provide('$authService', container.get<IAuthService>(TYPES.AuthService))
app.provide('$formatterService', container.get<IFormatter>(TYPES.FormatterService))
app.provide('$userService', container.get<IUserService>(TYPES.UserService))

app.use(router)

app.mount('#app')