<template>
  <div class="flex items-center justify-center w-full h-screen">
    <Card class="w-[350px]">
      <CardHeader>
        <CardTitle class="text-center">Sign up to VueSquad</CardTitle>
      </CardHeader>
      <form @submit="onSubmit">
        <CardContent class="space-y-3">
          <FormField v-slot="{ componentField }" name="name">
            <FormItem>
              <FormLabel>Name</FormLabel>
              <FormControl>
                <Input type="text" placeholder="Name" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
          <FormField v-slot="{ componentField }" name="email">
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input type="email" placeholder="Email" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
          <FormField v-slot="{ componentField }" name="password">
            <FormItem>
              <FormLabel>Password</FormLabel>
              <FormControl>
                <Input type="password" placeholder="Password" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
          <FormField v-slot="{ componentField }" name="password_confirmation">
            <FormItem>
              <FormLabel>Confirm your password</FormLabel>
              <FormControl>

                <Input type="password" placeholder="Password confirmation" v-bind="componentField" />
              </FormControl>
            </FormItem>
            <FormMessage />
          </FormField>
        </CardContent>
        <CardFooter>
          <Button type="submit" :loading="isSubmitting" variant="default" class="flex-1">Submit</Button>
        </CardFooter>
        <p class="text-center text-sm pb-4">Already have an account? <strong>
            <RouterLink to="/login">Sign in</RouterLink>
          </strong></p>

      </form>
    </Card>
  </div>
</template>
<script setup lang="ts">
import router from '@/app/router';
import Button from '@/components/ui/button/Button.vue';
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { FormField } from '@/components/ui/form';
import FormControl from '@/components/ui/form/FormControl.vue';
import FormItem from '@/components/ui/form/FormItem.vue';
import FormLabel from '@/components/ui/form/FormLabel.vue';
import FormMessage from '@/components/ui/form/FormMessage.vue';
import Input from '@/components/ui/input/Input.vue';
import { useApi, useNotice } from '@/ui/hooks';
import { toTypedSchema } from '@vee-validate/zod';
import { useForm } from 'vee-validate';
import { z } from 'zod';
const { showError, showSuccess } = useNotice()
const { authService } = useApi()
const formSchema = toTypedSchema(z.object({
  email: z.string().email().min(1),
  name: z.string().min(1),
  password: z.string().min(1),
  password_confirmation: z.string().min(1)
}).refine((data) => data.password === data.password_confirmation, {
  message: "Passwords are not the same",
  path: ["password_confirmation"]
}))
const { handleSubmit, isSubmitting } = useForm({
  validationSchema: formSchema
})
const onSubmit = handleSubmit(async (values) => {
  const response = await authService.register({ name: values.name, email: values.email, password: values.password, password_confirmation: values.password_confirmation })
 if (response.isFailure) {
    showError(response.errorMessage)
  }
  if (response.isSuccess) {
    showSuccess("Registered with sucess")
    router.push("/login")
  }
});
</script>
