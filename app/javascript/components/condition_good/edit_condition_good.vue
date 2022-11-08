<template>
  <section>
        <div class="modal-card" style="width: 62em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{ modalHeader }}</p>
        <button type="button" class="delete" @click="$emit('close')" />
      </header>
      <section class="modal-card-body" ref="editConditionGood">

        <b-tabs>
          <div class="box">
            <div v-if="condition_good" class="columns is-centered">
              <div class="column is-centered">
        
                    <div class="center"><h1>Datos del estado del Bien</h1></div>
 
                    <div v-show='!(condition_good.condition_id != 2)'>

                    <b-collapse :open="false" aria-id="contentIdForA11y1">
                      <template #trigger="props">
                        <b-field grouped position="is-right">
                          <b-button
                            label="Volver a designar"
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
                              </b-field>
                            </div>


                            <div class="column">
                              <b-field label="Nueva persona encargada">
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
                              </b-field>
                            </div>
                          </div>
                          <div class="columns">
                            <div class="column">
                              <b-field label="Nuevo Edificio">
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
                              </b-field>
                            </div>

                            <div class="column">
                              <b-field label="Nueva Dependencia">
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
                              </b-field>
                            </div>
                          </div>
                          <b-field grouped position="is-right">
                            <p class="control">
                              <b-button
                                label="Guardar"
                                type="is-info"
                                @click="confirmeditDes(condition_good.good_id)"
                              />
                            </p>
                          </b-field>
                        </div>
                      </div>
                    </b-collapse>

                    </div>

                    <div class="columns">
                      <div class="column"  v-show='!(condition_good.income_reason == null)'>
                        <b-field label="Motivo de ingreso">
                          <b-input
                            v-model="condition_good.income_reason"
                            type="textarea"
                            placeholder="Ingrese detalles del motivo de ingreso"
                          ></b-input>
                        </b-field>

                      </div>

                      <div class="column"  v-show='!(condition_good.loss_detail == null)'>
                        <b-field label="Descripción de perdida">
                          <b-input
                            v-model="condition_good.loss_detail"
                            type="textarea"
                            placeholder="Ingrese detalles de la perdida del bien"
                          ></b-input>
                        </b-field>

                      </div>
                      <div class="column"  v-show='!(condition_good.destruction_detail == null)'>
                        <b-field label="Descripción de destrucción">
                          <b-input
                            v-model="condition_good.destruction_detail" 
                            type="textarea"
                            placeholder="Ingrese detalles de la destrucción del bien"
                          ></b-input>
                        </b-field>
         
                      </div>
                    </div>

                    <div class="columns">
                      <div class="column"  v-show='!(condition_good.repairable == null)'>
                        <b-field label="¿Es reparable?">
                        <multiselect v-model="aux_repairable" :options="reparable" placeholder="¿Es reaparable?"
                          selectLabel="Presione para seleccionar" selectedLabel="Seleccionado"
                          deselectLabel="Presione para deseleccionar" :allow-empty="true">
                        </multiselect>
                              </b-field>
                      </div>
                      </div>
                                        <div class="columns">
                      <div class="column">
                       <b-field label="Link de documento enlace">
                        <b-input v-model="condition_good.link" placeholder="Ingrese el link del documento correspondiente">
                        </b-input>
                      </b-field>
                      </div>
                      </div>

                    <b-field grouped position="is-right">
                      <p class="control">
                        <b-button
                          label="Guardar"
                          type="is-info"
                          @click="confirmedit()"
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
      </section>
</template>


<script>
import axios from "axios";
import moment from "moment";
export default {
  props: ["queryType", "modalHeader", "condition_goodId", "id", "goodId"],
  data() {
    return {
      condition_good: null,
      goods: [],
      props: ["id"],
      offices: [],
      units: [],
      managers: [],
      buildings: [],
      aux_unit_id: null,
      aux_duty_manager_id: null,
      aux_building_id: null,
      aux_office_id: null,
      aux_repairable: null,
      null_activegood: 0,
      reparable: ['SI', 'NO'],
      des_activegood: 1,

    };
  },
  methods: {
    async getconditiongoods() {
      const response = await axios.get("/condition_goods/" + this.id + ".json");
      this.condition_good = response.data;
      console.log(this.auxdate);
    },
  
    async EditClick() {
      const response = await axios.put("/condition_goods/" + this.id + ".json", {
        income_reason: this.condition_good.income_reason,
        loss_detail: this.condition_good.loss_detail,
        link: this.condition_good.link,
        destruction_detail: this.condition_good.destruction_detail,
        repairable: this.aux_repairable,
      });
      window.location.href = "/condition_goods/" + this.id;
    },

    confirmedit() {
      this.$buefy.dialog.confirm({
        title: "Editar el Bien",
        message: `¿Esta seguro de editar el detalle del estado?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClick(),
      });
    },


        async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
          item +
          ".json"
      );
      this.managers = response.data;
      console.log(this.managers);
      console.log(this.buildings);
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
      console.log(this.offices);
    },

    async getofficebybuilding(item) {
      const response = await axios.get(
        "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
      );
      this.offices = response.data;
    },


        async EditClickDes(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        duty_manager_id: this.aux_duty_manager_id,
        office_id: this.aux_office_id,
        activegood: this.des_activegood,
      });
      this.AnulClick();
      window.location.href = "/goods/" + item;
    },

    confirmeditDes(item) {
      this.$buefy.dialog.confirm({
        title: "Editar el Bien",
        message: `¿Esta seguro que quiere reasignar el bien?`,
        cancelText: "Cancelar",
        confirmText: "Guardar",
        type: "is-info",
        onConfirm: () => this.EditClickDes(item),
      });
    },
    async getunitactive() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;
    },

        async AnulClick() {
      const response = await axios.put("/condition_goods/" + this.id + ".json", {
        activeconditiongood: this.null_activegood,
      });
    },


  },
  created() {
    this.getunitactive();
    this.getconditiongoods();
  },
};
</script>




