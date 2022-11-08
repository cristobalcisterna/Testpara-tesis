<template>
  <section>
        <!-- Box de Formulario Evento -->
        <div class="modal-card" style="width: auto" id="modal-event">
          <header class="modal-card-head">
            <p class="modal-card-title ">Contacto Soporte Nombre Aplicación Base</p>
            <button
                type="button"
                class="delete"
                @click="$emit('close')"/>
          </header>
          <section class="modal-card-body" id="modal-events">
           <div>
            <body>
             <p>
              En caso de necesitar soporte, enviar un correo a: <a href="https://mail.google.com/mail/u/0/?view=cm&amp;fs=1&amp;tf=1&amp;source=mailto&amp;to=proyectosinformaticos.fing@usach.cl" >proyectosinformaticos.fing@usach.cl</a> con su solicitud.
            </p>
            </body>
           </div>
          </section>
        </div>
        <footer class="modal-card-foot actions">
          <div class="field is-grouped is-pulled-right">
            <button class="button" type="button" @click="$emit('close')">Cerrar</button>
          </div>
        </footer>
    <b-loading :is-full-page="true" v-model="isLoading" :can-cancel="false"></b-loading>
  </section>
</template>

<script>
export default {
  name: 'contact_modal',
  data() {
    return {
      isLoading: false,
    }
  },
  props:[
  ],
  created(){
    this.isLoading=true
    this.isLoading=false

  },
  methods: {
  }
}
</script>

<style scoped>

</style>

