<template>
  <section>
    <div class="modal-card" style="width: 62em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ modalHeader }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body" ref="editGood">
        <b-tabs>
          <div class="box">
            <div v-if="good" class="columns is-centered">
              <div class="column is-centered">



      <b-tabs type="is-boxed" position="is-centered">

         <b-tab-item label="Datos">

          <!--Cambio datos-->

          <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
      <form @submit.prevent="handleSubmit(confirmedit())" >
                    <div class="center"><h1>Datos del Bien</h1></div>

                    <div class="columns">
                      <div class="column">
                        <b-field label="Nombre">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.namegood"
                            placeholder="Ingrese el nombre del bien"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                      <div class="column">
                        <b-field label="Marca">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.trademark"
                            placeholder="Ingrese la marca o el modelo del bien"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>

                       <div class="column">
                        <b-field label="Monto bruto">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                           <b-numberinput
                    min="0"
                    v-model="good.amount"
                    type="is-info"
                    placeholder="Ingrese el monto bruto del bien"
                  >
                  </b-numberinput>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                    </div>
                    <div class="columns">
                      <div class="column">
                        <b-field label="Numero inventario usach">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.identification_number_usach"
                            placeholder="Ingrese el numero inventario usach del bien"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>

                      <div class="column">
                        <b-field label="Numero inventario">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.identification_number_good"
                            placeholder="Ingrese el numero inventario del bien"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                      <div class="column">
                        <b-field label="Fecha de asignación">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-datepicker
                            v-model="aux_date_release"
                            locale="es-ES"
                            placeholder="Seleccionar fecha de asignación"
                            trap-focus
                          >
                          </b-datepicker>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                    </div>

                    <div class="columns">
                      <div class="column">
                        <b-field label="Numero de serie">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.serie_number"
                            placeholder="Ingrese el numero de serie del bien"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>

                      <div class="column">
                        <b-field label="Numero interno">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.internal_number"
                            placeholder="Ingrese el numero interno del bien"
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                      <div class="column">
                        <b-field label="Ubicación">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.location_good"
                            placeholder="Ingrese la ubicación del bien (Edificio, oficina, en que piso se encuentra.."
                          ></b-input>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                    </div>

                    <div class="columns">



                    <div class="column">
                              <b-field label="Tipo de inversión">
                                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                                <multiselect
                                  v-model="aux_investment_type_id"
                                  :options="investment_types.map((type) => type.id)"
                                  :custom-label="
                                    (opt) =>
                                      investment_types.find((x) => x.id === opt).name_investment_type
                                  "
                                  placeholder="Seleccionar fuente Tipo de inversión"
                                  selectedLabel="Seleccionado"
                                   selectLabel=""
                                  :allow-empty="true">
                                </multiselect>
                                <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                              </b-field>
                            </div>

                    <div class="column">
                              <b-field label="Fuente de Financiamiento">
                                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                                <multiselect
                                  v-model="aux_financial_source_id"
                                  :options="financial_sources.map((type) => type.id)"
                                  :custom-label="
                                    (opt) =>
                                      financial_sources.find((x) => x.id === opt).name_financial_source
                                  "
                                  placeholder="Seleccionar fuente de financiamiento"
                                  selectedLabel="Seleccionado"
                                   selectLabel=""
                                  :allow-empty="true">
                                </multiselect>
                                <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                              </b-field>
                            </div>

                      <div class="column">
                        <b-field label="Fecha de Compra">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-datepicker
                            v-model="aux_date_purchase"
                            locale="es-ES"
                            placeholder="Seleccionar fecha de compra"
                            trap-focus
                          >
                          </b-datepicker>
                          <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                        </b-field>
                      </div>
                    </div>

                    <div class="columns">
                      <div class="column">
                        <b-field label="Descripción">
                          <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                          <b-input
                            v-model="good.good_description"
                            placeholder="Ingrese una descripción del bien o el nombre"
                            type="textarea"
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
                          @click="checkEditData()"
                        />
                      </p>
                    </b-field>
                  </form>
                  </ValidationObserver>
                 </b-tab-item>



<!--Cambio cargo-->






















                <b-tab-item label="Cargos">      
                  <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
                    <form @submit.prevent="handleSubmit(confirmeditDes())" >    
                    <div class="center"><h1>Designación del Bien</h1></div>
                    <div class="columns" v-show='!(good.activegood == 2)'>
                      <div class="column">
                        <b-field label="Unidad">
                          <b-input
                            v-model="good.duty_manager.name_unit"
                            type="text"
                            readonly
                          ></b-input>
                        </b-field>
                      </div>
                      <div class="column">
                        <b-field label="Persona encargada">
                          <b-input
                            v-model="good.duty_manager.name_duty_manager"
                            type="text"
                            readonly
                          ></b-input>
                        </b-field>
                      </div>
                    </div>

                    <div class="columns" v-show='!(good.activegood == 2)'>
                      <div class="column">
                        <b-field label="Edificio">
                          <b-input
                            v-model="good.office.name_building"
                            type="text"
                            readonly
                          ></b-input>
                        </b-field>
                      </div>

                      <div class="column">
                        <b-field label="Dependencia">
                          <b-input
                            v-model="good.office.name_office"
                            type="text"
                            readonly
                          ></b-input>
                        </b-field>
                      </div>
                    </div>



                  <div v-show='!(good.activegood == 2)'>
                    <b-collapse :open="false" aria-id="contentIdForA11y1">
                      <template #trigger="props">
                        <b-field grouped position="is-right">
                          <b-button
                            label="Cambiar designación"
                            type="is-info"
                            aria-controls="contentIdForA11y1"
                            :aria-expanded="props.open"
                          />
                          
                        </b-field>
                      </template>

                      <div class="notification">
                        <div class="content">
                          <h1 class="has-text-left">Nueva designación</h1>

                          <div class="columns">


                            <div class="column">
                              <b-field label="Nueva Unidad">
                                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                                <multiselect
                                  v-model="aux_unit_id"
                                  :options="units.map((type) => type.id)"
                                  :custom-label="
                                    (opt) =>
                                      units.find((x) => x.id === opt).name_unit
                                  "
                                  placeholder="Seleccionar Unidad"
                                  selectedLabel="Seleccionado"
                                   selectLabel=""
                                  :allow-empty="true"
                                  :disabled="
                                    aux_duty_manager_id !== null ||
                                    aux_building_id !== null
                                  "
                                  @input="
                                    getdutymanagerbyunit(aux_unit_id);
                                    getbuildingbyunit(aux_unit_id);
                                  "
                                >
                                </multiselect>
                                <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                              </b-field>
                            </div>


                            <div class="column">
                              <b-field label="Nueva persona encargada">
                                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                                <multiselect
                                  v-model="aux_duty_manager_id"
                                  :options="managers.map((type) => type.id)"
                                  :custom-label="
                                    (opt) =>
                                      managers.find((x) => x.id === opt)
                                        .name_duty_manager
                                  "
                                  placeholder="Seleccionar persona encargada"
                                  selectLabel="Presione para seleccionar"
                                  selectedLabel="Seleccionado"
                                  deselectLabel="Presione para deseleccionar"
                                  :allow-empty="true"
                                  :disabled="aux_unit_id == null"
                                >
                                </multiselect>
                                <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                              </b-field>
                            </div>
                          </div>
                          <div class="columns">
                            <div class="column">
                              <b-field label="Nuevo Edificio">
                                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                                <multiselect
                                  v-model="aux_building_id"
                                  :options="buildings.map((type) => type.id)"
                                  :custom-label="
                                    (opt) =>
                                      buildings.find((x) => x.id === opt)
                                        .name_building
                                  "
                                  placeholder="Seleccionar Unidad"
                                  selectLabel="Presione para seleccionar"
                                  selectedLabel="Seleccionado"
                                  deselectLabel="Presione para deseleccionar"
                                  :allow-empty="true"
                                  :disabled="
                                    aux_unit_id == null ||
                                    aux_office_id !== null
                                  "
                                  @input="getofficebybuilding(aux_building_id)"
                                >
                                </multiselect>
                                <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                              </b-field>
                            </div>

                            <div class="column">
                              <b-field label="Nueva Dependencia">
                                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                                <multiselect
                                  v-model="aux_office_id"
                                  :options="offices.map((type) => type.id)"
                                  :custom-label="
                                    (opt) =>
                                      offices.find((x) => x.id === opt)
                                        .name_office
                                  "
                                  placeholder="Seleccionar dependencia"
                                  selectLabel="Presione para seleccionar"
                                  selectedLabel="Seleccionado"
                                  deselectLabel="Presione para deseleccionar"
                                  :allow-empty="true"
                                  :disabled="aux_building_id == null"
                                >
                                </multiselect>
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
                                @click="checkCharge()"
                              />
                            </p>
                          </b-field>
                        </div>
                      </div>
                    </b-collapse>
                    </div>
                  </form>
                  </ValidationObserver>
                  </b-tab-item>

                   </b-tabs>

              </div>
            </div>

            <div v-else>
              <p>Loading</p>
            </div>
          </div>
        </b-tabs>
      </section>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import IndexGoods from "./index_good.vue";
import moment from "moment";
export default {
  name: "edit_good",
  props: ["queryType", "modalHeader", "goodId", "id"],
  components: {
    "index-good": IndexGoods,
  },

  data() {
    return {
      good: null,
      goods: [],
      props: ["id"],
      offices: [],
      units: [],
      managers: [],
      buildings: [],
      financial_sources: [],
      investment_types: [],
      aux_good_description: null,
      aux_identification_number_usach: null,
      aux_identification_number_good: null,
      aux_serie_number: null,
      aux_internal_number: null,
      aux_trademark: null,
      aux_location_good: null,
      aux_unit_id: null,
      aux_date_release: new Date(),
      aux_amount: null,
      aux_date_purchase: new Date(),
      aux_duty_manager_id: null,
      aux_building_id: null,
      aux_investment_type_id: null,
      aux_financial_source_id: null,
      aux_office_id: null,
    };
  },
  methods: {
    async getgoods() {
      const response = await axios.get("/goods/" + this.id + ".json");
      this.loading = true;
      this.good = response.data;
      this.aux_date_release = new Date(this.good.date_release);
      this.aux_financial_source_id = this.good.financial_source_id;
      this.aux_investment_type_id = this.good.financial_source_id;
      
    },

    async getunitactive() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;
    },

        async getfinancialsource() {
      const response = await axios.get("http://localhost:3000/financial_sources.json");
      this.financial_sources = response.data;
    },

        async getinvestmenttype() {
      const response = await axios.get("http://localhost:3000/investment_types.json");
      this.investment_types = response.data;
    },


    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
          item +
          ".json"
      );
      this.managers = response.data;
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
    },

    async EditClick() {
      const response = await axios.put("/goods/" + this.id + ".json", {
        namegood: this.good.namegood,
        good_description: this.good.good_description,
        identification_number_usach: this.good.identification_number_usach,
        identification_number_good: this.good.identification_number_good,
        serie_number: this.good.serie_number,
        internal_number: this.good.internal_number,
        trademark: this.good.trademark,
        location_good: this.good.location_good,
        date_release: this.aux_date_release,
        amount: this.good.amount,
        date_purchase: this.good.aux_date_purchase,
        financial_source_id: this.aux_financial_source_id,
        investment_type_id: this.aux_investment_type_id,
      });
      window.location.href = "/goods/" + this.id;
    },

    confirmedit() {
      this.$buefy.dialog.confirm({
        title: "Editar el Bien",
        message: `¿Esta seguro de editar esté bien?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClick(),
      });
    },
    confirmeditDes() {
      this.$buefy.dialog.confirm({
        title: "Editar el Bien",
        message: `¿Esta seguro de editar esté bien?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClickDes(),
      });
    },
    async checkEditData(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmedit();
    }
    },
    async checkCharge(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmeditDes();
    }
    },


    async EditClickDes() {
      const response = await axios.put("/goods/" + this.id + ".json", {
        duty_manager_id: this.aux_duty_manager_id,
        office_id: this.aux_office_id,
        activegood: 1,
      });
      window.location.href = "/goods";
    },

    

    confirmeditDes2() {
      this.$buefy.dialog.confirm({
        title: "Editar el Bien",
        message: `¿Esta seguro de editar esté bien?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClickDes(),
      });
    },

    async check(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmregister();
    }
    },

    
  },
  created() {
    this.getgoods();
    this.getunitactive();
    this.getfinancialsource();
    this.getinvestmenttype();
  },
};
</script>




