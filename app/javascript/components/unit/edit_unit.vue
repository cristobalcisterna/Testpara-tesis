<template>
  <section>
    <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
      <form @submit.prevent="handleSubmit(confirmedit())" >
    <div class="modal-card" style="width: 62em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ modalHeader }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body" ref="editUnit">
        <b-tabs>


    <div class="box">
            <div v-if="unit" class="columns is-centered">
              <div class="column is-centered">

                    
                    <div class="center"><h1>Datos de la unidad</h1></div>

                    <div class="columns">
                      <div class="column">
                        <b-field label="Nombre de Unidad">
                          <ValidationProvider name="Nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="unit.name_unit"
                            placeholder="Ingrese el Nombre de Unidad"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                        </ValidationProvider>
                        </b-field>
                      </div>
                    </div>



                    <div class="columns">
                      <div class="column">
                        <b-field label="N° Identificación">
                          <ValidationProvider name="Identificación" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="unit.identification_number_unit"
                            placeholder="Ingrese el numero de identificación de la unidad"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                        </ValidationProvider>
                        </b-field>
                      </div>
                    </div>


                     <div class="columns">
                      <div class="column">
                        <b-field label="Descripción">
                          <ValidationProvider name="Descripción" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="unit.description_unit"
                            placeholder="Ingrese la descripción de la unidad"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                        </ValidationProvider>
                        </b-field>
                      </div>
                    </div>


                    <b-field grouped position="is-right">
                      <p class="control">
                        <b-button
                          label="Guardar"
                          type="is-info"
                          @click="check()"
                        />
                      </p>
                    </b-field>
        

              </div>
            </div>

            <div v-else>
              <p>Loading</p>
            </div>
          </div>
        </b-tabs>
      </section>
    </div>
  </form>
 </ValidationObserver>
  </section>
</template>


<script>
import axios from "axios";
import IndexUnits from "./index_unit.vue";
import moment from "moment";
export default {
  name: "edit_unit",
  props: ["queryType", "modalHeader", "unitId", "id"],
  components: {
    "index-unit": IndexUnits,
  },

  data() {
    return {
      unit: null,
      units: [],
      props: ["id"],

    };
  },
  methods: {
    async getunit() {
      const response = await axios.get("/units/" + this.id + ".json");
      this.loading = true;
      this.unit = response.data;   
    },

    async EditClick() {
      const response = await axios.put("/units/" + this.id + ".json", {
        name_unit: this.unit.name_unit,
        description_unit: this.unit.description_unit,
        identification_number_usach: this.unit.identification_number_usach,
        identification_number_unit: this.unit.identification_number_unit,
      });
      window.location.href = "/units/" + this.id;
    },

    confirmedit() {
      this.$buefy.dialog.confirm({
        title: "Editar la unidad",
        message: `¿Esta seguro de editar esta unidad?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClick(),
      });
    },
    async check(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmedit();
    }
    },



    
  },
  created() {
    this.getunit();
  },
};
</script>




