$(document).ready(function(){

    $("#user_form").validate({

       rules:{
	
			"user[username]":{
                required: true,
            },

            "user[name]":{
                required: true,
                minlength: 5,
            },

			"user[email]":{
                required: true,
                email: true,
            },

			"user[password]":{
                required: true,
                minlength: 3,
                maxlength: 16,
            },

			"user[password_confirmation]":{
                required: true,
				equalTo: "#user_password",
            },

			"user[password_confirmation]":{
                required: true,
				equalTo: "#user_password",
            },

			"user[position]":{
                required: true,
				minlength: 3,
                maxlength: 16,
            },

			"user[organization_id]":{
                required: true,
            },

			"user[division]":{
                required: true,
				minlength: 3,
                maxlength: 16,
            },

			"user[work_status]":{
                required: true,
            },
			


       },

       messages:{
	
			"user[username]":{
                required: "Это поле обязательно для заполнения",
            },

            "user[name]":{
                required: "Это поле обязательно для заполнения",
				minlength: "Имя должно состоять минимум из 5 букв",
            },

			"user[email]":{
                required: "Это поле обязательно для заполнения",
                email: "Укажите корректный формат электронной почты",
            },

            "user[password]":{
                required: "Это поле обязательно для заполнения",
                minlength: "Пароль должен быть минимум 8 символов",
                maxlength: "Пароль должен быть максимум 16 символов",
            },

			"user[password_confirmation]":{
                required: "Это поле обязательно для заполнения",
                equalTo: "Подтверждение должно совпадать с паролем",
            },

			"user[phone]":{
                required: "Это поле обязательно для заполнения",
                digits: "Укажите телефон числом",
				minlength: "Телефон должен быть минимум 7 цифр",
                maxlength: "Максимальное число цифр - 16",
            },

			"user[position]":{
                required: "Это поле обязательно для заполнения",
				minlength: "Поле должен быть минимум 3 символа",
                maxlength: "Максимальное значение для поля - 16 символов",
            },

			"user[organization_id]":{
                required: "Выберите организацию",
            },

			"user[division]":{
                required: "Это поле обязательно для заполнения",
				minlength: "Поле должен быть минимум 3 символа",
                maxlength: "Максимальное значение для поля - 16 символов",
            },

			"user[dob]":{
                required: "Это поле обязательно для заполнения",
                dateISO: "Пожалуйста, укажите корректный формат даты",
            },

			"user[permit]":{
                required: "Это поле обязательно для заполнения",
                minlength: "Пожалуйста, укажите корректный формат",
                maxlength: "Пожалуйста, укажите корректный формат",
            },

			"user[work_status]":{
                required: "Это поле обязательно для заполнения",
            },

       }

    });
});